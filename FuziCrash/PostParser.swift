//
//  PostParser.swift
//  ProjectS1
//
//  Created by kukushi on 8/13/15.
//  Copyright (c) 2014 Xing He. All rights reserved.
//

import UIKit
import Fuzi

extension XMLElement {
    var isLeaf: Bool {
        return children.isEmpty
    }
}

protocol PostParserDelegate: class {
    func postParserDidFinishFetchImage(with postID: String)
    func postParserDidClicked(attachment: NSTextAttachment)
}

typealias StringAttributes = [NSAttributedString.Key: Any]

struct ContentContext {
    enum ContentType {
        case none
        case quote
    }

    var type = ContentType.none
}

public final class PostParser {
    func parse(str: String) -> NSTextStorage {
        let document: XMLDocument
        do {
            document = try XMLDocument(string: str)
        } catch {
            return NSTextStorage()
        }
        
        let textStorage = NSTextStorage()
        guard let root = document.root else {
            return textStorage
        }
        
        parseTextNodeAndChildren(element: root)
        return NSTextStorage()
    }
    
    func parseTextNodeAndChildren(element: XMLElement,
                                  parentAttributes: StringAttributes? = nil,
                                  context: ContentContext? = nil) {
        // Text Node is the untagged content in HTML file
        let textNodes = element.childNodes(ofTypes: [.Text])
        var index = 0
        let textCount = textNodes.count
        
        print(textNodes)
        print(element)
        print(element.children)

        for child in element.children {
            if index < textCount && textNodes[index].nextSibling == child {
                processPlainTextWithAttachments(content: textNodes[index].stringValue,
                                                parentAttributes: parentAttributes,
                                                context: context)
                index += 1
            }
//            parse(element: child, parentAttributes: parentAttributes, context: context)
        }

        for index in index..<textNodes.count {
            processPlainTextWithAttachments(content: textNodes[index].stringValue, parentAttributes: parentAttributes, context: context)
        }
    }
    
    @discardableResult
    func processPlainTextWithAttachments(content: String,
                                         parentAttributes: StringAttributes? = nil,
                                         context: ContentContext? = nil) -> Bool {
        var fixedContent = content
        if let context = context, case ContentContext.ContentType.quote = context.type {
            if content == "引用:" {
                // Return false to indicate that we don't need the new line for ">"
                fixedContent = "> "
//                textStorage.append(composeAttributedString(with: fixedContent, attributes: parentAttributes))
                return false
            }
        }
        
        print(fixedContent)

//        guard let attachments = attachments else {
////            textStorage.append(composeAttributedString(with: fixedContent, attributes: parentAttributes))
//            return true
//        }

//        let attachmentsInfo = extractAttachment(from: fixedContent)
//        if attachmentsInfo.isEmpty {
////            textStorage.append(composeAttributedString(with: fixedContent, attributes: parentAttributes))
//        } else {
//            // Separate attachment from text
//            let content = fixedContent as NSString
//            var currentLocation = 0
//            for (attachmentRange, attachmentTag) in attachmentsInfo {
//                let start = attachmentRange.location
//                if start > currentLocation {
//                    let range = NSRange(location: currentLocation, length: start - currentLocation)
//                    let text = content.substring(with: range)
//                    textStorage.append(composeAttributedString(with: text, attributes: parentAttributes))
//                }
//                let attachment = attachments[attachmentTag]
//                guard let imageURL = attachment?.fullURL else { continue }
//
//                let imageAttachment = centeredImageAttachment(with: imageURL, ID: identifier)
//                textStorage.append(imageAttachment)
//                processedAttachments?[attachmentTag] = nil
//
//                currentLocation = start + attachmentRange.length
//            }
//
//            let fullLength = content.length
//            if currentLocation != fullLength {
//                let range = NSRange(location: currentLocation, length: fullLength - currentLocation)
//                let text = content.substring(with: range)
//                textStorage.append(composeAttributedString(with: text, attributes: parentAttributes))
//            }
//        }
        return true
    }

}
