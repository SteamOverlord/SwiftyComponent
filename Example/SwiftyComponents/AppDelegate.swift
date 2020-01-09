//
//  AppDelegate.swift
//  SwiftyComponents
//
//  Created by pavel.mosunov@anoda.mobi on 09/19/2019.
//  Copyright (c) 2019 pavel.mosunov@anoda.mobi. All rights reserved.
//

import UIKit
import SwiftyComponents

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?


    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        
        let mainScene = Scene(isRootScene: true)
        let rootObject = WelcomeScreenObject(UINavigationController(rootViewController: ViewController()))
        mainScene.attachRootObject(rootObject)
        
        let randomObjec = Object()
        let randomUIObj = UIObject(ViewController())
        
        mainScene.attachObject(randomObjec)
        mainScene.attachObject(randomUIObj)
        //добавь сценарии и управление ими. Работа с объектами и компонентами должна проходить не в тут.
        
//        let obj = mainScene.getObject(byClass: Object.self)
//        let uiObj = mainScene.getObject(byClass: UIObject.self)
        
        window = mainScene
        mainScene.shouldBecomKeyAndVisible(isRoot: true)
        return true
    }


}

