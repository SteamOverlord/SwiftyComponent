//
//  ViewController.swift
//  Pods-SwiftyComponents_Example
//
//  Created by Pavel on 9/25/19.
//

import Foundation
import UIKit

public protocol UIControllerLifeCycleProtocol: class {
    
    //    called on start
    func attachView() -> UIView
    
    var title: String { get }
    
    func onUpdate()
}

public class UIController<T: UIViewController>: UIRepresentable {
    public typealias classType = T.Type
    
    var root: T
    
    required public init() {
        root = T.init()
    }
    
//    public init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
//        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
//    }
//    
//    public required init?(coder aDecoder: NSCoder) {
//        fatalError("init(coder:) has not been implemented")
//    }
//    
//    public weak var lifeCycleProtocol: UIControllerLifeCycleProtocol?
//    
//    override public func loadView() {
//        view = lifeCycleProtocol?.attachView()
//    }
//    
//    override public func viewDidLoad() {
//        super.viewDidLoad()
//        title = lifeCycleProtocol?.title
//    }
    
    
}
