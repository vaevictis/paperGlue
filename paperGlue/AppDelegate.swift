//
//  AppDelegate.swift
//  paperGlue
//
//  Created by vaevictis on 19/02/2015.
//  Copyright (c) 2015 guillaume hammadi. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?


    func application(application: UIApplication, didFinishLaunchingWithOptions launchOptions: [NSObject: AnyObject]?) -> Bool {
        println("didFinishLaunchingWithOptions")
        
        return true
    }
    
    func application(application: UIApplication, openURL url: NSURL, sourceApplication: String?, annotation: AnyObject?) -> Bool {
        return true
    }

    func applicationWillResignActive(application: UIApplication) {
    }

    func applicationDidEnterBackground(application: UIApplication) {
    }

    func applicationWillEnterForeground(application: UIApplication) {
        println("will enter foreground")
    }

    func applicationDidBecomeActive(application: UIApplication) {
        println("didBecomeActive")
    }

    func applicationWillTerminate(application: UIApplication) {
    }


}

