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

open class TObject: Object {
    
    //Ref to scene.
    private weak var parent: Scene?
    
    //list of all components
    private var components = [Component]()
    
    public var rootObject: Object?
    public var rootComponent: Component?
    
    private override init() {
        
    }
    
    var owner: Scene? {
        return parent
    }
   
    //MARK: Instances
    
    static func instantiate(_ componentList: Component...) -> TObject {
        let instance = TObject()
        instance.attachComponents(componentList)
        return instance
    }
    
    static func instantiate(_ componentEntities: ComponentEntity...) -> TObject {
        let instance = TObject()
        
        for componentEntity in componentEntities {
            instance.attachComponent(instantiateComponent(componentEntity))
        }
        
        return instance
    }
    
    //MARK: Component Handlers
    
    func attachComponents(_ list: [Component]) {
        components += list
    }
    
    func attachComponent(_ component: Component) {
        components += [component]
    }
    
    func removeComponent(_ component: Component) {
        components.removeAll { (comp) -> Bool in
            return comp.entityID == component.entityID
        }
        
    }
    
    func getComponent<T: Component>(byClass type: T.Type) -> T? {
        return components.first(where: { $0 is T }) as? T
    }
    
    func getComponents<T: Component>(byClass type: T.Type) -> [T]? {
        return components.filter({ $0 is T }) as? [T]
    }
    
    //MARK: LifeCycle
    
    //MARK: Privates
    
    private func attachOwner(to component: Component) {
        component.ownerRef = self
    }
    
    private static func instantiateComponent(_ componentEntity: ComponentEntity) -> Component {
        let component = componentEntity.componentType
        .instantiate(componentEntity.componentData)
        return component
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
