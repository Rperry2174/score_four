//
//  ViewController.swift
//  score_four
//
//  Created by Ryan Perry on 9/21/17.
//  Copyright © 2017 Ryan Perry. All rights reserved.
//

import UIKit
import SceneKit
import ARKit

class ViewController: UIViewController, ARSCNViewDelegate {

    @IBOutlet var sceneView: ARSCNView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Set the view's delegate
        sceneView.delegate = self
        
        // Show statistics such as fps and timing information
        sceneView.showsStatistics = true
        
        // Create a new scene
//        let scene = SCNScene(named: "art.scnassets/score_four_01.dae")!
        let scene = SCNScene()
        // Set the scene to the view
        sceneView.scene = scene
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)

        // Create a session configuration
        let configuration = ARWorldTrackingConfiguration()

        // Run the view's session
        sceneView.session.run(configuration)
        addBase()
    }
    

    func addBase() {
        let base = Base()
        base.loadModel()
        let position = SCNVector3(0, 0, -3)
        base.position = position
        base.buildPoleArray()
        
//        for pole in base.poleArray{
//            sceneView.scene.rootNode.addChildNode(pole)
//            for bead in pole.beadArray{
//                sceneView.scene.rootNode.addChildNode(bead)
//            }
//        }
        
        for node in sceneView.scene.rootNode.childNodes {
            print("NODE: ", node)
            print("Subject Type: ", type(of: node))
            // following if block runs if the node is a pole
            if let typeOfNode = node as? Pole {
                print("THIS IS A POLE NODE  ")
                print("Type of Node result: ", typeOfNode)
                print("name of that pole node", node)
                print("=====================")
            }
        }
        
        sceneView.scene.rootNode.addChildNode(base)
    }
    
    func randomPosition (lowerBound lower:Float, upperBound upper:Float) -> Float{
        return Float(arc4random()) / Float(UInt32.max) * (lower - upper) + upper
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        if let touch = touches.first {
            let location = touch.location(in: sceneView)
            let hitList = sceneView.hitTest(location, options: nil)
            
            if let hitObject = hitList.first {
                let node = hitObject.node
                print("Hit object", hitObject)
                print("printing the child nodes", node.childNodes)
            }
        }
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        // Pause the view's session
        sceneView.session.pause()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Release any cached data, images, etc that aren't in use.
    }

    // MARK: - ARSCNViewDelegate
    
/*
    // Override to create and configure nodes for anchors added to the view's session.
    func renderer(_ renderer: SCNSceneRenderer, nodeFor anchor: ARAnchor) -> SCNNode? {
        let node = SCNNode()
     
        return node
    }
*/
    
    func session(_ session: ARSession, didFailWithError error: Error) {
        // Present an error message to the user
        
    }
    
    func sessionWasInterrupted(_ session: ARSession) {
        // Inform the user that the session has been interrupted, for example, by presenting an overlay
        
    }
    
    func sessionInterruptionEnded(_ session: ARSession) {
        // Reset tracking and/or remove existing anchors if consistent tracking is required
        
    }
}
