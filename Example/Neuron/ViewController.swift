//
//  ViewController.swift
//  Neuron
//
//  Created by Draveness on 11/09/2015.
//  Copyright (c) 2015 Draveness. All rights reserved.
//

import UIKit
import Neuron

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        let target: TargetObject = "view"
        let signal: NeuronSignal = NeuronSignal(target: target)
        view.neuron.basedOnTarget("view") { (value) -> () in
            self.view.backgroundColor = UIColor.redColor()
        }
        signal.fire()
    }

}

