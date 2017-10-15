//
//  MyNode.swift
//  score_four
//
//  Created by Ryan Perry on 10/14/17.
//  Copyright © 2017 Ryan Perry. All rights reserved.
//

import UIKit
import ARKit

class MyNode : SCNNode {
    init(name: String) {
        super.init()
        self.name = name
    }
    /* Xcode required this */
    required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}


