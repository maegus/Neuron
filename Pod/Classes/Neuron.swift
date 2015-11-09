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

    public var neuron: Neuron {
        get {
            return Neuron(object: self)
        }
    }

}

public class Neuron {
    private var behaviorDictionary: [String: NNBehaviorBlock] = [:]
    private weak var object: AnyObject?

    public init(object: AnyObject) {
        self.object = object
    }

    public func basedOnTarget(target: TargetObject, behaviorBlock: NNBehaviorBlock) -> Neuron {
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "stimulus", name: target.name, object: nil)
        behaviorDictionary[target.identifier] = behaviorBlock
        return self
    }

    private func stimulus(notification: NSNotification) {
        if let signal = notification.object as? NeuronSignal {
            if let behaviorBlock = behaviorDictionary[signal.target.identifier] {
                behaviorBlock(signal.value)
            }
        }
    }
}