//
//  Base.swift
//  score_four
//
//  Created by Ryan Perry on 9/28/17.
//  Copyright © 2017 Ryan Perry. All rights reserved.
//

import UIKit
import ARKit

class Base: SCNNode {
    
    var itemName = "base"
    var modelMat: [[String]] =
    [
        ["Pole0", "Pole1", "Pole2" , "Pole3"],
        ["Pole4", "Pole5", "Pole6" , "Pole7"],
        ["Pole8", "Pole9", "Pole10" , "Pole11"],
        ["Pole12", "Pole13", "Pole14" , "Pole15"]
    ]
    
    var modelMatArr: [[[Int]]] = [[[1, 1, 1, 1], [1, 1, 1, 1], [0, 0, 0, 0], [1, 1, 1, 1]],
                                [[0, 0, 0, 0], [0, 0, 0, 0], [0, 0, 0, 0], [0, 0, 0, 0]],
                                [[0, 0, 0, 0], [0, 0, 0, 0], [0, 0, 0, 0], [0, 0, 0, 0]],
                                [[0, 0, 0, 0], [0, 0, 0, 0], [0, 0, 0, 0], [0, 0, 0, 0]]]
    
    var poleArray: [Pole] = []
    
    func rowWin(){
        for row in 0...3 { //modelMatArr
            for pol in 0...3 {
                var isFullCount = 0
                for beadPosition in 0...3 {
                    print("Hi my name is: ", self.modelMatArr[row][pol][beadPosition])
                    isFullCount += Int(self.modelMatArr[row][pol][beadPosition])
                }
                if(isFullCount == 4) {
                    print("WINNER")
                }
            }
        }
    }
    
    func polWin(){
        for row in 0...3 { //modelMatArr
            for pol in 0...3 {
                var isFullCount = 0
                for beadPosition in 0...3 {
                    print("Hi my name is (POLE): ", self.modelMatArr[row][pol][beadPosition])
                    isFullCount += Int(self.modelMatArr[row][pol][beadPosition])
                }
                if(isFullCount == 4) {
                    print("WINNER")
                }
            }
        }
    }
    
    func colWin(){
        for beadPosition in 0...3 { //modelMatArr
            for pol in 0...3 {
                var isFullCount = 0
                for row in 0...3 {
                    print("Hi my name is (COLUMN): ", self.modelMatArr[row][pol][beadPosition])
                    isFullCount += Int(self.modelMatArr[row][pol][beadPosition])
                }
                if(isFullCount == 4) {
                    print("WINNER")
                }
            }
        }
    }
    
    func buildCoordinatesArr(low: Float, high: Float) -> [Float] {
        let range = abs(low) + abs(high)
        var emptyArray: [Float] = []
        let sections: [Float] = [1.0, 1.0, 1.0, 1.0, 1.0]
        let sectionWidth = range / Float(sections.count)
        
        for index in 0...3 {
            if index == 0 {
                let start = low
                emptyArray.append(start + sectionWidth / Float(2))
            } else {
                let start = low + sectionWidth * Float(index)
                emptyArray.append(start + sectionWidth / Float(2))
            }
        }
        
        return emptyArray
    }
    
    func buildPoleArray(){
        let xCoordLow = Float(position.x) - 1.2
        let xCoordHigh = Float(position.x) + 1.45
        
        let zCoordLow = Float(position.z) - 0.3
        let zCoordHigh = Float(position.z) + 2.85

        var xCoordinateArray: [Float] = buildCoordinatesArr(low: xCoordLow, high: xCoordHigh)
        var zCoordinateArray: [Float] = buildCoordinatesArr(low: zCoordLow, high: zCoordHigh)

        for row in 0...3 { //modelMatArr
            for col in 0...3 {
                let xCoord = xCoordinateArray[row]
                let zCoord = zCoordinateArray[col]
                let position = SCNVector3(xCoord, 0, zCoord)
                addPole(position: position, itemName: (String(xCoord) + " 0 " + String(zCoord)), beadModel: self.modelMatArr[row][col])
            }
        }
    }
    
    func addPole(position: SCNVector3, itemName: String, beadModel: [Int]){
        let pole = Pole()
        pole.loadModel(position: position)
        pole.itemName = itemName
        pole.setBeadModel(beadModel: beadModel)
        pole.renderBeadsFromBeadModel()
        self.poleArray.append(pole)
    }
    
    func loadModel(){
        guard let virtualObjectScene = SCNScene(named: "art.scnassets/score_four_01.dae") else {return}
        let wrapperNode = SCNNode()
        for child in virtualObjectScene.rootNode.childNodes{
            wrapperNode.addChildNode(child)
        }
//        rowWin()
//        polWin()
//        colWin()
        self.buildPoleArray()
        wrapperNode.addChildNode(self.poleArray[0])

        self.addChildNode(wrapperNode)
        
    }
    
}
