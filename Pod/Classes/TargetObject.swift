//
//  TargetObject.swift
//  Pods
//
//  Created by Draveness on 15/11/9.
//
//

import Foundation


public protocol TargetObject {
    var identifier: String { get }
}

extension TargetObject {
    var name: String {
        get {
            return "Neuron.Signal.\(self.identifier)"
        }
    }
    func transmitter(object: AnyObject) -> NSNotification {
        return NSNotification(name: name, object: object)
    }
}

extension NSString: TargetObject {
    public var identifier: String {
        return self as String
    }
}

extension String: TargetObject {
    public var identifier: String {
        return self
    }
}