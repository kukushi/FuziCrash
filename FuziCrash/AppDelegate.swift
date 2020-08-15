//
//  AppDelegate.swift
//  FuziCrash
//
//  Created by kukushi on 2020/8/15.
//

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {



    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        
        let xmlWithBasicTypes = """
            <root>
              <string>the string value</string>
              <int>100</int>
              <double>100.45</double>
              <float>44.12</float>
              <bool1>0</bool1>
              <bool2>true</bool2>
              <empty></empty>
              <basicItem id="1234">
                <name>the name of basic item</name>
                <price>99.14</price>
              </basicItem>
              <attribute int=\"1\"/>
            </root>
        """
        PostParser().parse(str: xmlWithBasicTypes)
        return true
    }

    // MARK: UISceneSession Lifecycle

    func application(_ application: UIApplication, configurationForConnecting connectingSceneSession: UISceneSession, options: UIScene.ConnectionOptions) -> UISceneConfiguration {
        // Called when a new scene session is being created.
        // Use this method to select a configuration to create the new scene with.
        return UISceneConfiguration(name: "Default Configuration", sessionRole: connectingSceneSession.role)
    }

    func application(_ application: UIApplication, didDiscardSceneSessions sceneSessions: Set<UISceneSession>) {
        // Called when the user discards a scene session.
        // If any sessions were discarded while the application was not running, this will be called shortly after application:didFinishLaunchingWithOptions.
        // Use this method to release any resources that were specific to the discarded scenes, as they will not return.
    }


}

