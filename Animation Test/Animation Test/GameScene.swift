//
//  GameScene.swift
//  Animation Test
//
//  Created by Sam Dillin on 6/18/19.
//  Copyright © 2019 Sam Dillin. All rights reserved.
//

import SpriteKit
import GameplayKit

class GameScene: SKScene {
    
    var recognizer = UITapGestureRecognizer()
    
    var TextureAtlas = SKTextureAtlas()
    var TextureAtlas1 = SKTextureAtlas()
    var HandTextureAtlas = SKTextureAtlas()
    
    var TextureArray = [SKTexture]()
    var HandTextureArray = [SKTexture]()
    
    var MainGuy = SKSpriteNode()
    var Background = SKSpriteNode()
    
    var Hand : [SKSpriteNode] = [SKSpriteNode]()
    var stackNum = Int()
    var colorNum = [Int]()
    
    var touchedNode = SKSpriteNode()
    var lastTouched = CGPoint()
    
    var colorName = 0
    
    override func didMove(to: SKView){
        /* Setup scene here*/
        
        recognizer.numberOfTapsRequired = 2
        recognizer.cancelsTouchesInView = false
        recognizer.delaysTouchesBegan = true
        recognizer.addTarget(self, action:#selector(self.handleTap))
        view?.addGestureRecognizer(recognizer)
        
        recognizer.delegate = self as? UIGestureRecognizerDelegate
        
        TextureAtlas = SKTextureAtlas(named: "images")
        TextureAtlas1 = SKTextureAtlas(named: "background")
        HandTextureAtlas = SKTextureAtlas(named: "card")
        
        
        for i in 0...TextureAtlas.textureNames.count - 1{
            
            var Name = "testguy\(i).png"
            TextureArray.append(SKTexture(imageNamed: Name))
        }
        
        initArrays(HandTextureArray: &HandTextureArray)
        
        
        initMainNodes(Background: &Background, MainGuy: &MainGuy, TextureAtlas: TextureAtlas, TextureAtlas1: TextureAtlas1)
        
       
        
        for i in 0...HandTextureAtlas.textureNames.count - 1{
            if(HandTextureAtlas.textureNames[i] == "Stack_card.png"){
                stackNum = i
            }
            else{
                colorNum.append(i)
            }
        }
        
        Hand.append(SKSpriteNode(imageNamed: HandTextureAtlas.textureNames[stackNum]))
        
        Hand[0].size = CGSize(width: 216, height: 399)
        Hand[0].position = CGPoint(x: 275, y: -475)
        Hand[0].zPosition = 5
        Hand[0].name = "Stack"
        
        self.addChild(MainGuy)
        self.addChild(Background)
        self.addChild(Hand[0])
        
        
    }
    
    @objc func handleTap(sender: UITapGestureRecognizer) {
            if sender.state == .ended {
                
                    var currentCardToBeRemoved = 0
                if(Hand.count > 1){
                    for card in Hand{
                        if card != Hand[0]{
                            let returnToStack = SKAction .move(to: CGPoint(x:275, y:-475), duration: 0.1)
                            currentCardToBeRemoved = Hand.firstIndex(of: card)!
                            card.run(returnToStack)
                            if(Hand.count > 1){
                                Hand.remove(at: currentCardToBeRemoved)
                            currentCardToBeRemoved += 1
                            colorName -= 1
                                
                                
                                print(colorName)
                                print(card.name)
                                print("+",Hand.count)
                                card.removeFromParent()
                            }
                        }
                        
                    }
                }
                
            }
        }

    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
       
        
        
        let touch:UITouch = touches.first!
        let positionInScene = touch.location(in: self)
        touchedNode = self.atPoint(positionInScene) as! SKSpriteNode
        
        for touch: AnyObject in touches {
            let touchLocation = touch.location(in: self)
            lastTouched = touchLocation
        }
        
        
        if let name = touchedNode.name
        {
            if name == "Stack"
            {
                // handleTap(sender: recognizer)
                print("*", recognizer.numberOfTapsRequired)
                print("Touched")
                var validNum = Int.random(in: 0...colorNum.count)
                
                while validNum == stackNum{
                    validNum = Int.random(in: 0...colorNum.count)
                }
                
                Hand.append(SKSpriteNode(imageNamed: HandTextureAtlas.textureNames[validNum]))
                Hand[Hand.count-1].size = CGSize(width: 216, height: 399)
                var newXposition = Hand[0].position.x - 107
                var newYposition = Hand[0].position.y
                Hand[Hand.count-1].position = CGPoint(x: newXposition,                                                            y: newYposition)
                Hand[Hand.count-1].zPosition = 4
                Hand[Hand.count-1].name = "color\(colorName)"
                colorName += 1
                Hand[Hand.count-1].isUserInteractionEnabled = false
                print(Hand.count-1)
                print(colorNum.count)
                self.addChild(Hand[Hand.count-1])
            }
            else if name == "MainGuy"{
                MainGuy.run(SKAction.repeatForever(SKAction.animate(with: TextureArray, timePerFrame: 0.05)))
            }
            
            var isColorNodeSelected = false
            var currentNodeSelectedNum = 0
            
            for i in 0...colorName{
                if (name == "color\(i)"){
                    isColorNodeSelected = true
                    currentNodeSelectedNum = i+1;
                }
            }
             
             if (isColorNodeSelected == true) {
                touchedNode.position.x = lastTouched.x
                touchedNode.position.y = lastTouched.y
                
                touchedNode.shadowedBitMask = 1
                
                for card in Hand{
                    if(card != Hand[currentNodeSelectedNum]  && card != Hand[0]){
                        card.scale(to: CGSize(width: 162, height: 299))
                        card.zPosition = 3
                    }
                }
                
               
            }
            print(touchedNode.name)
            print(self.childNode(withName: "color"))
        }
      
    }
    
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        let touch:UITouch = touches.first!
        let positionInScene = touch.location(in: self)
        touchedNode = self.atPoint(positionInScene) as! SKSpriteNode
        
        for touch: AnyObject in touches {
            let touchLocation = touch.location(in: self)
            lastTouched = touchLocation
        }
        
        if(touchedNode.name != "Stack" && touchedNode.name != "background" && touchedNode.name != "MainGuy"){
        touchedNode.position = lastTouched
        }
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        
        
        
        if(Hand.count > 2){
        for card in Hand{
            if(card != Hand[0]){
            card.scale(to: CGSize(width: 216, height: 399))
                card.zPosition = 4
            }
        }
        }
    }
    
    
    override func update(_ currentTime: TimeInterval) {
        
        let touch = lastTouched
        
       
        
        let xOffset = (touch.x - touchedNode.position.x)*2
        let yOffset = (touch.y - touchedNode.position.y)*2
                let impulseVector = CGVector(dx: xOffset, dy: yOffset)
                touchedNode.physicsBody?.applyImpulse(impulseVector)
        
        
        }
        

}
