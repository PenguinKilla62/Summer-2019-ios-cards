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
    
    var Placement: [SKSpriteNode] = [SKSpriteNode]()
    var PlacementTextureAtlas = SKTextureAtlas()
    var PlacementTexture = SKTexture()
    
    var Played:[SKSpriteNode] = [SKSpriteNode]()
    
    var Hand : [SKSpriteNode] = [SKSpriteNode]()
    var stackNum = Int()
    var colorNum = [Int]()
    
    var touchedNode = SKSpriteNode()
    var lastTouched = CGPoint()
    
    var colorName = 0
    
    var lightNode = SKLightNode()
    
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
        PlacementTextureAtlas = SKTextureAtlas(named: "Placement")
        
        initPlacement(Placement: &Placement, PlacementTextureAtlas: &PlacementTextureAtlas)
        
        for i in 0...TextureAtlas.textureNames.count - 1{
            
            var Name = "testguy\(i).png"
            TextureArray.append(SKTexture(imageNamed: Name))
        }
        
        for i in 0...HandTextureAtlas.textureNames.count - 1{
            if(HandTextureAtlas.textureNames[i] == "Stack_card.png"){
                stackNum = i
            }
            else{
                colorNum.append(i)
            }
        }
        
        initArrays(HandTextureArray: &HandTextureArray)
        
        
        initMainNodes(Background: &Background, MainGuy: &MainGuy, Hand: &Hand, lightNode: &lightNode, TextureAtlas: TextureAtlas, TextureAtlas1: TextureAtlas1, HandTextureAtlas: HandTextureAtlas, stackNum: stackNum)
        
        self.addChild(MainGuy)
        self.addChild(Background)
        self.addChild(Hand[0])
        self.addChild(lightNode)
        
        for place in Placement{
            self.addChild(place)
        }
        
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
                            
                        }
                    }
                    
                }
                for card in Hand{
                    
                    if card != Hand[0]{
                    card.removeFromParent()
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
                lightNode.isEnabled = true
                lightNode.position = Hand[0].position
                
                createCard(Hand: &Hand, HandTextureAtlas: &HandTextureAtlas, stackNum: stackNum, colorName: &colorName, colorNum: colorNum)
                
                print(Hand.count-1)
                print(colorNum.count)
                self.addChild(Hand[Hand.count-1])
                //sortHand(Hand: &Hand)
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
                
                touchedNode.shadowedBitMask = 0
                currentNodeSelectedNum = Hand.firstIndex(of: touchedNode)!
                Hand[currentNodeSelectedNum].scale(to: CGSize(width: 270, height: 498))
                lightNode.isEnabled = true
                touchedNode.lightingBitMask = 0
                
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
        var isPlacement = false
        for i in 0...5{
            if touchedNode.name == "Placement\(i)"{
                isPlacement = true
            }
        }
        
        var isPlayed = false
        for i in 0...(Played.count){
            if touchedNode.name == "Played\(i)"{
                isPlayed = true
            }
            
        }
        
        if(touchedNode.name != "Stack" && touchedNode.name != "background" && touchedNode.name != "MainGuy" && isPlacement == false && isPlayed == false){
            touchedNode.position = lastTouched
            lightNode.position = touchedNode.position
            for card in Hand{
                if(card != Hand[0] && card != touchedNode){
                    let currentCard = Hand.firstIndex(of: card)!
                    let moveToHand = SKAction .move(to: CGPoint(x:200 + (-50 * ((Hand.count-1) - currentCard)), y:-475), duration: 0.1)
                    card.run(moveToHand)
                }
            }
        }
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        lightNode.isEnabled = false
        
        checkIfCardPlayed(touchedNode: &touchedNode, Hand: &Hand, Placement: &Placement, Played: &Played, colorName: &colorName)
        
        if(Hand.count > 2){
            for card in Hand{
                if(card != Hand[0]){
                    card.scale(to: CGSize(width: 162, height: 299))
                    card.zPosition = 4
                    let currentCard = Hand.firstIndex(of: card)!
                    let moveToHand = SKAction .move(to: CGPoint(x:150 + (-50 * ((Hand.count-1) - currentCard)), y:-475), duration: 0.1)
                    let shrink = SKAction .resize(toWidth: (CGFloat(262 / ((Hand.count)))), height: (399), duration: 0.1)
                    card.run(moveToHand)
                    card.run(shrink)
                    print(card.position)
                    
                }
                card.lightingBitMask = 1
            }
            
        }
        
    }
    
    
    
    override func update(_ currentTime: TimeInterval) {
        
    }
    
    override func didFinishUpdate() {
      
    }
}
