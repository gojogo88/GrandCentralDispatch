//
//  AppDelegate.swift
//  FirstJson
//
//  Created by Jonathan Go on 2017/07/12.
//  Copyright © 2017 Appdelight. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?  //storyboard automatically creates a window in which all the viewControllers are shown. This window needs to know what its initial viewControler is and that gets set in its rootview controller property (see if let tabBarController) and is all handled by the storyboard.

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        
        //to add another tab via code
        if let tabBarController = window?.rootViewController as? UITabBarController {
            //in a single view application template, the root view controller is the viewController, but we embedded it inside a navigationController and then embedded that inside a tabBarController. So our root viewController is a UITabBarController.
            
            let storyboard = UIStoryboard(name: "Main", bundle: nil)  //nil means use my current app bundle
            let vc = storyboard.instantiateViewController(withIdentifier: "NavController")  //this creates our viewController. "NavController" is the storyboard ID of our tabBarController.
            
            vc.tabBarItem = UITabBarItem(tabBarSystemItem: .topRated, tag: 1)  //this is the new tab created.
            
            tabBarController.viewControllers?.append(vc)  //this adds it to the array and cause it to appear in the tab bar.
        }
        
        return true
    }

    func applicationWillResignActive(_ application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
    }

    func applicationDidEnterBackground(_ application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    }

    func applicationWillEnterForeground(_ application: UIApplication) {
        // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
    }

    func applicationDidBecomeActive(_ application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }

    func applicationWillTerminate(_ application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    }


}

