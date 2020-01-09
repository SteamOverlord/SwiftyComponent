//
//  Scene.swift
//  Pods-SwiftyComponents_Example
//
//  Created by Pavel on 9/19/19.
//

import Foundation
import UIKit

//Scene is the main application routing

open class Scene: UIWindow {
    
    private var rootObject: UIObject?
    
    private var sceneObjects = [Object]()
    
    public init(isRootScene: Bool = true) {
        super.init(frame: .zero)
        shouldBecomKeyAndVisible(isRoot: isRootScene)
    }
    
    required public init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    public func shouldBecomKeyAndVisible(isRoot: Bool) {
        if isRoot {
            makeKeyAndVisible()
        }
    }
    
    public func attachRootObject(_ object: UIObject) {
        rootObject = object
        rootViewController = object.root
    }
    
    public func attachObject(_ object: Object) {
        object.ownerRef = self
        sceneObjects.append(object)
        
    }
    
    public func transitionFromRoot(to object: UIObject,
                                   _ animated: Bool = true ,
                                   completion: (() -> Void)? = nil) {
        //TODO: Perhaps better throw error: non navigatoinController available
        if let navigationStack = rootObject?.root as? UINavigationController {
            navigationStack.pushViewController(object.root,
                                               animated: animated)
        } else {
            rootObject?.root.present(object.root,
                                              animated: animated,
                                              completion: completion)
        }
    }
    
    public func getObject<T: Object>(byClass typeClass: T.Type) -> T? {
        
//        return sceneObjects.first(where: { (object) -> Bool in
//            return object is T
//        }) as? T
        return sceneObjects.first(where: { $0 is T }) as? T
    }
    
    internal func transit(from current: UIObject,
                          to object: UIObject,
                          animated: Bool,
                          isModal: Bool = true,
                          modalCompletion: (() -> Void)? = nil) {
        if isModal {
            current.root.present(object.root,
                                           animated: animated,
                                           completion: modalCompletion)
        } else {
            guard let navigation = current.root as? UINavigationController else { return }
            navigation.pushViewController(object.root, animated: animated)
        }
    }
}
