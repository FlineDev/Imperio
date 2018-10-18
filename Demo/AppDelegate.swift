//
//  AppDelegate.swift
//  Imperio
//
//  Created by Cihat Gündüz on 01.11.17.
//  Copyright © 2017 Flinesoft. All rights reserved.
//

import Imperio
import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    var window: UIWindow?
    var initialFlowController: InitialFlowController?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]? = nil) -> Bool {
        window = UIWindow(frame: UIScreen.main.bounds)
        window?.makeKeyAndVisible()

        initialFlowController = MainFlowController()
        initialFlowController?.start(from: window!)

        return true
    }
}
