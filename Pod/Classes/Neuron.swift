//
//  Neuron.swift
//  Pods
//
//  Created by Draveness on 15/11/9.
//
//

import Foundation
import ObjectiveC

public typealias NNBehaviorBlock = Any -> ()

public extension NSObject {

    private struct AssociatedKey {
        static var Neuron = "neuron"
    }

    public var neuron: Neuron {
        get {
            if let neuron = objc_getAssociatedObject(self, &AssociatedKey.Neuron) {
                return neuron as! Neuron
            } else {
                let neuron = Neuron(object: self)
                objc_setAssociatedObject(self, &AssociatedKey.Neuron, neuron, .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
                return neuron
            }
        }
    }

}

public class Neuron: NSObject {
    private var behaviorDictionary: [String: NNBehaviorBlock] = [:]
    private weak var object: AnyObject?

    public init(object: AnyObject) {
        self.object = object
    }

    public func basedOnTarget(target: TargetObject, behaviorBlock: NNBehaviorBlock) -> Neuron {
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "stimulus:", name: target.name, object: nil)
        behaviorDictionary[target.identifier] = behaviorBlock
        return self
    }

    func stimulus(notification: NSNotification) {
        if let signal = notification.object as? NeuronSignal {
            if let behaviorBlock = behaviorDictionary[signal.target.identifier] {
                behaviorBlock(signal.value)
            }
        }
    }
}