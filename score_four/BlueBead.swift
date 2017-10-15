//
//  BlueBead.swift
//  score_four
//
//  Created by Ryan Perry on 10/2/17.
//  Copyright © 2017 Ryan Perry. All rights reserved.
//

import UIKit
import ARKit

class BlueBead: SCNNode {
    var itemName: String?
    
    func loadModel(position: SCNVector3){
        guard let virtualObjectScene = SCNScene(named: "art.scnassets/blue_bead_01.dae") else {return}
        let wrapperNode = SCNNode()
        for child in virtualObjectScene.rootNode.childNodes{
            wrapperNode.addChildNode(child)
        }
        self.addChildNode(wrapperNode)
        self.position = position
    }
}
