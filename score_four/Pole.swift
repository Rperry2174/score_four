//
//  Pole.swift
//  score_four
//
//  Created by Ryan Perry on 9/30/17.
//  Copyright © 2017 Ryan Perry. All rights reserved.
//
//
//  Base.swift
//  score_four
//
//  Created by Ryan Perry on 9/28/17.
//  Copyright © 2017 Ryan Perry. All rights reserved.
//

import UIKit
import ARKit

class Pole: SCNNode {
    var itemName: String?
    var beadArray: [BlueBead] = []
    var beadModel: [Int] = [0, 0, 0, 0]
    
    func setBeadModel(beadModel: [Int]){
        self.beadModel = beadModel
    }
    
    func addBlueBead(position: SCNVector3, itemName: String){
        let blueBead = BlueBead(name: itemName)
        blueBead.loadModel(position: position)
        blueBead.itemName = itemName
        self.beadArray.append(blueBead)
    }
    
    func buildCoordinatesArr(low: Float, high: Float) -> [Float] {
        let range = abs(low) + abs(high)
        var emptyArray: [Float] = []
        let sections: [Float] = [1.0, 1.0, 1.0, 1.0]
        let sectionWidth = range / Float(sections.count)
        
        for index in 0...3 {
            if index == 0 {
                let start = low
                emptyArray.append(start)
            } else {
                let start = low + sectionWidth * Float(index)
                emptyArray.append(start)
            }
        }
        
        return emptyArray
    }
    
    func renderBeadsFromBeadModel() {
        let coordsArray = buildCoordinatesArr(low: -0.9, high: 0.1)
        var index = 0
        for bead in self.beadModel {
            if bead == 1 {
                var beadPosition = self.position
                beadPosition.y = coordsArray[index]
                addBlueBead(position: beadPosition, itemName: String(coordsArray[index]))
            }
            index += 1
        }
    }
    func loadModel(position: SCNVector3){
        guard let virtualObjectScene = SCNScene(named: "art.scnassets/pole_01.dae") else {return}

        let wrapperNode = SCNNode()
        print("wrapperNode: ", wrapperNode)
        for child in virtualObjectScene.rootNode.childNodes{
//            print("THIS IS THE CHILD BEING ADDED", child)
            wrapperNode.addChildNode(child)
        }
        self.position = position
        self.addChildNode(wrapperNode)
    }
}
