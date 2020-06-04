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
    
    var Played = [SKSpriteNode(), SKSpriteNode(), SKSpriteNode(),
                SKSpriteNode(), SKSpriteNode(), SKSpriteNode()]
    var PlayedColors = ["","","","","",""]
    
    var computerHand = [SKSpriteNode]()
    
    var Hand : [SKSpriteNode] = [SKSpriteNode]()
    var HandColors = [String]()
    
    var stackNum = Int()
    var colorNum = [Int]()
    
    var touchedNode = SKSpriteNode()
    var lastTouched = CGPoint()
    
    var colorName = 0
    
    var lightNode = SKLightNode()
    
    var round = 0
    let playerDraw = 2
    var didPlayerRedraw = false
    
    var playerHPLabelNode = SKLabelNode()
    var playerHPLabelSpriteNode = SKSpriteNode()
    
    var endGameLabel = SKLabelNode()
    var endGameLabelNode = SKSpriteNode()
    
    override func didMove(to: SKView){
        /* Setup scene here*/
        
        self.removeAllChildren()
        
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
        
        
        initMainNodes(Background: &Background, MainGuy: &MainGuy, Hand: &Hand, lightNode: &lightNode, TextureAtlas: TextureAtlas, TextureAtlas1: TextureAtlas1, HandTextureAtlas: HandTextureAtlas, stackNum: stackNum, playerHPLabelNode: &playerHPLabelNode, playerHPLabelSpriteNode: &playerHPLabelSpriteNode)
        
        self.addChild(MainGuy)
        self.addChild(Background)
       // self.addChild(Hand[0])
        self.addChild(lightNode)
        self.addChild(playerHPLabelSpriteNode)
        
        var currentscene = self
        
        startHand(GeneralHand: &Hand, GameScene: &currentscene, HandTextureAtlas: &HandTextureAtlas, stackNum: stackNum, colorName: &colorName, colorNum: colorNum, HandColors: &HandColors)
        
        for place in Placement{
            self.addChild(place)
        }
        

        
        
    }
    
    
    
    @objc func handleTap(sender: UITapGestureRecognizer) {
        if sender.state == .ended {
            var currentCardToBeRemoved = 0
            var currentNumOfCardsToBeRedrawn = Hand.count-1
            if(Hand.count > 1){
                for card in Hand{
                    if card != Hand[0]{
                        let returnToStack = SKAction .move(to: CGPoint(x:275, y:-475), duration: 0.1)
                        currentCardToBeRemoved = Hand.firstIndex(of: card)!
                        card.run(returnToStack)
                        if(Hand.count > 1){
                            self.removeChildren(in: [self.childNode(withName: card.name!)!])
                            Hand.remove(at: currentCardToBeRemoved)
                            HandColors.remove(at: currentCardToBeRemoved-1)
                            currentCardToBeRemoved += 1
                            colorName -= 1
                            
                            
                            print(colorName)
                            print(card.name)
                            print("+",Hand.count)
                            
                        }
                    }
                    
                }
                print("[",self.children.count)
                for card in Hand{
                    
                    if card != Hand[0]{
                        var hold = Hand.firstIndex(of: card)!
                        card.removeFromParent()
                        Hand.remove(at: hold)
                    }
                }
                print(self.children.count, "]")
                
            }
            didPlayerRedraw = true
            
            if didPlayerRedraw == true{
                
                
                        while Hand.count-1 < (currentNumOfCardsToBeRedrawn) {
                            createCard(Hand: &Hand, HandTextureAtlas: &HandTextureAtlas, stackNum: stackNum, colorName: &colorName, colorNum: colorNum, HandColors: &HandColors)
                        }
                for i in 0...Hand.count-1{
                    if i != 0{
                        self.addChild(Hand[i])
                    }
                }
                    }
            
            placeCardsInHand(Hand: &Hand)
            
                didPlayerRedraw = false
            }
            
        }
    
    
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        
        let touch:UITouch = touches.first!
        let positionInScene = touch.location(in: self)
        
        if self.atPoint(positionInScene) as? SKSpriteNode != nil{
        touchedNode = self.atPoint(positionInScene) as! SKSpriteNode
        
        
        
        for touch: AnyObject in touches {
            let touchLocation = touch.location(in: self)
            lastTouched = touchLocation
        }
        
        
        if let name = touchedNode.name
        {
//            if name == "Stack"
//            {
//                lightNode.isEnabled = true
//                lightNode.position = Hand[0].position
//
//                createCard(Hand: &Hand, HandTextureAtlas: &HandTextureAtlas, stackNum: stackNum, colorName: &colorName, colorNum: colorNum)
//
//                print(Hand.count-1)
//                print(colorNum.count)
//                self.addChild(Hand[Hand.count-1])
//
//
//            }
             if name == "MainGuy"{
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
                
                currentNodeSelectedNum = Hand.firstIndex(of: touchedNode)!
                
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
    }
    
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        
        var currentNodeSelectedNum = 0
        
        let touch:UITouch = touches.first!
        let positionInScene = touch.location(in: self)
         if self.atPoint(positionInScene) as? SKSpriteNode != nil{
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
            
<<<<<<< HEAD
            var isHand = false
            for i in 1...Hand.count{
=======
        var isHand = false
            for i in 1...Hand.count-1{
>>>>>>> parent of 05dd643... Added Rounds, Unfinished Calculations
                if touchedNode.name == "color\(i)"{
                    isHand = true
                }
            }
        
        if(isHand == true){
            touchedNode.position = lastTouched
            lightNode.position = touchedNode.position
            touchedNode.shadowedBitMask = 0
            currentNodeSelectedNum = Hand.firstIndex(of: touchedNode)!
            Hand[currentNodeSelectedNum].scale(to: CGSize(width: 270, height: 498))
            lightNode.isEnabled = true
            touchedNode.lightingBitMask = 0
            
            for card in Hand{
                if(card != Hand[0] && card != touchedNode){
                    let currentCard = Hand.firstIndex(of: card)!
                    let moveToHand = SKAction .move(to: CGPoint(x:150 + (-50 * ((Hand.count-1) - currentCard)), y:-475), duration: 0.1)
                    
                    card.run(moveToHand)
                }
            }
        }
        }
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        
        lightNode.isEnabled = false
        let touch:UITouch = touches.first!
        let positionInScene = touch.location(in: self)
        
         if self.atPoint(positionInScene) as? SKSpriteNode != nil{
        touchedNode = self.atPoint(positionInScene) as! SKSpriteNode
        
        
        var currentscene = self
            
<<<<<<< HEAD
            var isHand = false
            for i in 1...Hand.count{
=======
        var isHand = false
            for i in 1...Hand.count-1{
>>>>>>> parent of 05dd643... Added Rounds, Unfinished Calculations
                if touchedNode.name == "color\(i)"{
                    isHand = true
                }
            }
        
        if touchedNode.name == "MainGuy"{
            round += 1
            
<<<<<<< HEAD
            if touchedNode.name == "MainGuy"{
                isPlayerTurnOver = true
                
                drawCardsforHand(GeneralHand: &Hand, GameScene: &currentscene, HandTextureAtlas: &HandTextureAtlas, stackNum: stackNum, colorName: &colorName, colorNum: colorNum, numOfCardsToDraw: playerDraw, HandColors: &HandColors, isComputer: false)
                drawCardsforHand(GeneralHand: &opponentHand, GameScene: &currentscene, HandTextureAtlas: &HandTextureAtlas, stackNum: stackNum, colorName: &colorName, colorNum: colorNum, numOfCardsToDraw: opponentDraw, HandColors: &opponentHandColors, isComputer: true)
            }
            else if isHand == true{
                
                checkIfCardPlayed(touchedNode: &touchedNode, Hand: &Hand,scene: &currentscene, Placement: &Placement, Played: &Played, colorName: &colorName, HandColors: &HandColors, PlayedColors: &PlayedColors)
                
                placeCardsInHand(Hand: &Hand)
            }
            if(isPlayerTurnOver == true && isComputerTurnOver == true){
            var laneWinnerNum = calculatePlayedCards(Played: &Played, PlayedColors: &PlayedColors)
                finishRound(isPlayerTurnOver: &isPlayerTurnOver, isComputerTurnOver: &isComputerTurnOver, roundLabelSpriteNode: &roundLabelSpriteNode, Played: &Played, laneWinnerNum: laneWinnerNum, playerHPLabelSpriteNode: &playerHPLabelSpriteNode, computerHPLabelSpriteNode: &computerHpLabelSpriteNode, scene: &currentscene)
        }
            if isPlayerTurnOver == true && isComputerTurnOver == false{
                computerTurn(computerHand: &opponentHand, computerHandColors: &opponentHandColors, Played: &Played, PlayedColors: &PlayedColors)
                isComputerTurnOver = true
                
                var laneWinnerNum = calculatePlayedCards(Played: &Played, PlayedColors: &PlayedColors)
                finishRound(isPlayerTurnOver: &isPlayerTurnOver, isComputerTurnOver: &isComputerTurnOver, roundLabelSpriteNode: &roundLabelSpriteNode, Played: &Played, laneWinnerNum: laneWinnerNum, playerHPLabelSpriteNode: &playerHPLabelSpriteNode, computerHPLabelSpriteNode: &computerHpLabelSpriteNode, scene: &currentscene)
            }
            let viewcontroller = StartingPointViewController()
            self.view?.willMove(toWindow: UIWindow(frame: viewcontroller.accessibilityFrame))
//            if true {
//                let scene = StartingPointViewController()
//                let ControllerView = self.view as! UIViewController
//
//
//
//                let storyboard = UIStoryboard(name:"Storyboard", bundle: nil)
//                let startViewController = storyboard.instantiateViewController(withIdentifier: "StartingPoint") as! StartingPointViewController
//                startViewController.title = "StartingPoint"
//
//            }
            
//            var dumView = SKView(frame: CGRect())
//            self.view?.willRemoveSubview(self.view!)
            var dumUIView = StartingPointView()
            self.view?.addSubview(dumUIView)
            self.view?.willMove(toSuperview: dumUIView)
            self.view?.didMoveToSuperview()
            print(self.view?.subviews.count)
            self.view?.exchangeSubview(at: 0, withSubviewAt: 1)
            self.view?.superview?.willMove(toSuperview: dumUIView)
            
            self.view?.superview?.didMoveToSuperview()
            
            print(self.scene?.children)
            print("&", round, "&")
            //print("-", touchedNode.name, "-")
=======
            drawCardsforHand(GeneralHand: &Hand, GameScene: &currentscene, HandTextureAtlas: &HandTextureAtlas, stackNum: stackNum, colorName: &colorName, colorNum: colorNum, numOfCardsToDraw: playerDraw, HandColors: &HandColors)
        }else if isHand == true{
        
            checkIfCardPlayed(touchedNode: &touchedNode, Hand: &Hand,scene: &currentscene, Placement: &Placement, Played: &Played, colorName: &colorName, HandColors: &HandColors, PlayedColors: &PlayedColors)
        
        placeCardsInHand(Hand: &Hand)
        }
        calculatePlayedCards(Played: &Played, PlayedColors: &PlayedColors)
        print(self.scene?.children)
        print("&", round, "&")
        //print("-", touchedNode.name, "-")
>>>>>>> parent of 05dd643... Added Rounds, Unfinished Calculations
        }
    }
    
    
    
    
    override func update(_ currentTime: TimeInterval) {
        
    }
    
    override func didFinishUpdate() {
        
    }
}
