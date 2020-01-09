//
//  Object.swift
//  Pods-SwiftyComponents_Example
//
//  Created by Pavel on 9/19/19.
//

import Foundation
import UIKit

open class Object {
    var entityID: String { return String(describing: self) }
}

open class TObject<T: Object>: Object {
    
    //Ref to scene.
    internal weak var parent: Scene?
    
    //list of all components
    internal var components = [Component]()
    
    public var rootObject: Object?
    public var rootComponent: Component?
    
    private override init() {
        
    }
   
    static func instantiate(_ componentList: Component...) -> TObject<T> {
        let instance = TObject()
        instance.attachComponents(componentList)
        return instance
    }
    
    static func instantiate(_ componentEntities: ComponentEntity...) -> TObject<T> {
        let instance = TObject()
        
        for componentEntity in componentEntities {
            
        }
        
        return instance
    }
    
    func attachComponents(_ list: [Component]) {
        components += list
    }
    
    func attachComponent(_ component: Component) {
        components += [component]
    }
    
    func detachComponent(_ component: Component) {
        
    }
    
    private func instantiateComponent() {
        
    }
}


//open class Object: NSObject {
//
//    public var owner: Scene? {
//        get {
//            return ownerRef
//        }
//    }
//
//    internal weak var ownerRef: Scene?
//
//    internal var componentsList = [Component]()
//
//    public override init() {
//        super.init()
//    }
//
//    public func attachComponents(_ components: Component...) {
//        components.forEach({ $0.ownerRef = self })
//        componentsList.append(contentsOf: components)
//    }
//
//    public func getComponents<T: Component>(byClass type: T.Type) -> [T]? {
//        return componentsList.filter({ $0 is T}) as? [T]
//    }
//
//    //@func awake will be called once before start() called. It's more like loadView than init
//    open func awake() {}
//    //@func Called once attached
//    open func start() {}
//
//    open func willEnable() {}
//
//    open func onEnable() {}
//
//    open func update() {}
//
//    open func willDisable() {}
//
//    open func onDisable() {}
//
//    open func detached() {}
//}
//
//open class UIObject: Object {
//
//    var root: UIViewController
//    var view: UIView
//
//    public init(_ root: UIViewController) {
//        self.root = root
//        self.view = root.view
//
//        super.init()
//        (root as? ViewController)?.lifeCycleProtocol = self
//    }
//
//    // Do what ever you want on start
//    override open func start() {
//        super.start()
//
//        let uiComponents = getComponents(byClass: UIComponent.self)
//
//    }
//
//    public func transit(to object: UIObject,
//                        animated: Bool,
//                        isModal: Bool = true,
//                        modalCompletion: (() -> Void)? = nil) {
//        ownerRef?.transit(from: self, to: object, animated: animated, isModal: isModal, modalCompletion: modalCompletion)
//    }
//
//    public func attachRoot(component: UIComponent) {
//        componentsList.insert(component, at: 0)
//        view = component.uiRepresentation
//    }
//
//    public func attach(components: UIComponent...) {
//        componentsList.append(contentsOf: components)
//    }
//
//    public func isViewAttached() throws {
//        guard let vc = root as? ViewController else { return }
//        if vc.isViewLoaded == false {
//            throw ObjectError.failedToAttachView
//        }
//    }
//
//    public func adjust(rootComponent: UIComponent) {
//        root.view = rootComponent.uiRepresentation
//    }
//
//    open func setupLayout() {}
//}
//
//extension UIObject: ViewControllerLifeCycleProtocol {
//    public func attachView() -> UIView {
//        return view
//    }
//
//    public var title: String {
//        return ""
//    }
//
//    public func onUpdate() {
//        //TODO: call some kind of closure or perhaps functions
//    }
//}


public enum ObjectError: Error {
    case failedToAttachView
}

extension ObjectError: LocalizedError {
    var localizedDescription: String {
        switch self {
        case .failedToAttachView:
            return "UIObject: View was not set, or failed to be loaded."
        default:
            break
        }
    }
}
