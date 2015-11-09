//
//  NeuronSignal.swift
//  Pods
//
//  Created by Draveness on 15/11/9.
//
//

import Foundation

public class NeuronSignal {
    public var target: TargetObject
    public var value: Any {
        didSet {
            fire()
        }
    }

    public init(target: TargetObject) {
        self.target = target
        self.value = 0
    }

    public func fire() {
        NSNotificationCenter.defaultCenter().postNotification(target.transmitter(self))
    }
}