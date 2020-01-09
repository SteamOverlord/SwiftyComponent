//
//  Component.swift
//  Pods-SwiftyComponents_Example
//
//  Created by Pavel on 9/19/19.
//

import Foundation

open class Component: Equatable {
    
    public static func == (lhs: Component, rhs: Component) -> Bool {
        return lhs.entityID == rhs.entityID
    }
    
    var entityID: String {
        return String(describing: self)
    }
    
    public var owner: TObject? {
        get {
            return ownerRef
        }
    }
    
    internal weak var ownerRef: TObject?
    
    internal init(_ data: ComponentData?) {
        if let entityData = data {
           initialData(entityData)
        }
    }
    
    public static func instantiate(_ componentData: ComponentData? = nil) -> Component {
        let component = Component(componentData)
        return component
    }
    
    //Override to unpack component data
    open func initialData(_ data: ComponentData) {}
    
    //Override to handle detach state. Basically remove observers if any.
    open func onDetach() {}
}

//open class UIComponent: Component {
//
//    public typealias LayoutClosure = (_ uiObject: UIView?) -> Void
//
//    public var uiRepresentation: UIView
//    public var layoutBlock: (LayoutClosure)?
//    public var updateLayoutBlock: (LayoutClosure)?
//
//    public init(_ view: UIView) {
//        uiRepresentation = view
//    }
//
//    func setupLayout(previosElement: UIComponent?) throws {
//        guard let layoutBlock = self.layoutBlock else { throw UIComponentError.missedLayout }
//
//        if previosElement == nil {
//            layoutBlock(nil)
//        }
//        layoutBlock(previosElement?.uiRepresentation)
//    }
//
//    func updateLayout(previousElement: UIComponent?) throws {
//        guard let updateLayoutBlock = self.updateLayoutBlock else { throw UIComponentError.missedLayout }
//
//        if previousElement == nil {
//            updateLayoutBlock(nil)
//        }
//        updateLayoutBlock(previousElement?.uiRepresentation)
//    }
//}

enum UIComponentError: Error {
    case missedLayout
}

extension UIComponentError: LocalizedError {
    var localizedDescription: String {
        switch self {
        case .missedLayout:
            return "UIComponent: Failed to layout! Layout block could not be nil"
        default:
            break
        }
    }
}
