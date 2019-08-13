//
//  GameViewController.swift
//  Animation Test
//
//  Created by Sam Dillin on 6/18/19.
//  Copyright © 2019 Sam Dillin. All rights reserved.
//

import UIKit
import SpriteKit
import GameplayKit

class GameViewController: UIViewController {
    
    var computerCurrentHP = Int()
    var playerCurrentHP = Int()
    
    var computerTotalHP = 5
    var playerTotalHP = 5
    
    var totalRoundNum = Int()
    var currentRoundNum =  Int()
    var playerTurn = Bool()
    var computerTurn = Bool()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Load 'GameScene.sks' as a GKScene. This provides gameplay related content
        // including entities and graphs.
        if let scene = GKScene(fileNamed: "GameScene") {
            
            // Get the SKScene from the loaded GKScene
            if let sceneNode = scene.rootNode as! GameScene? {
                
                // Copy gameplay related content over to the scene
                
                // Set the scale mode to scale to fit the window
                sceneNode.scaleMode = .aspectFill
                
                // Present the scene
                if let view = self.view as! SKView? {
                    view.presentScene(sceneNode)
                    
                    view.ignoresSiblingOrder = true
                    
                    view.showsFPS = true
                    view.showsNodeCount = true
                }
            }
        }
        
        
        
    }
    override func viewDidAppear(_ animated: Bool) {
       mainGame()
        
       
//        let viewScene = self.view as? SKView
//        viewScene!.presentScene(scene)
        
  
        
    }
    

    func mainGame(){
        var scene =  GameScene()
        let ControllerView = self.view as! SKView
        
        
        scene.didMove(to: ControllerView)
        
        self.navigationController?.pushViewController(StartingPointViewController(), animated: true)
        }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "StartingPoint"{
            let startViewController = segue.destination as! StartingPointViewController
            startViewController.title = "Home"
        }
    }
    
    
    override var shouldAutorotate: Bool {
        return true
    }

    override var supportedInterfaceOrientations: UIInterfaceOrientationMask {
        if UIDevice.current.userInterfaceIdiom == .phone {
            return .allButUpsideDown
        } else {
            return .all
        }
    }

    override var prefersStatusBarHidden: Bool {
        return true
    }
}
