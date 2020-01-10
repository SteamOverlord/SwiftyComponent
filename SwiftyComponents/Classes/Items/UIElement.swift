//
//  UIElement.swift
//  Pods-SwiftyComponents_Example
//
//  Created by Pavel on 1/10/20.
//

import Foundation

open class UIElement<T: UIView>: UIRepresentable {
    public typealias classType = T.Type

    var root: T

    required public init() {
        root = T.init()
    }
    
}
