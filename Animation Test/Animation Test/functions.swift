//
//  functions.swift
//  Animation Test
//
//  Created by Sam Dillin on 8/1/19.
//  Copyright © 2019 Sam Dillin. All rights reserved.
//

import Foundation
import SpriteKit
import SceneKit


func stackToHand(Hand: inout[SKSpriteNode]){
    var newCard = Hand[Hand.count-1]
    
    let moveToHand = SKAction .move(to: CGPoint(x:0, y:-475), duration: 0.1)
    newCard.run(moveToHand)
    
    
}

func checkIfCardPlayed(touchedNode: inout SKSpriteNode, Hand: inout [SKSpriteNode], scene: inout GameScene,Placement: inout [SKSpriteNode], Played: inout [SKSpriteNode], colorName: inout Int){
    
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
    
    if(touchedNode.name != Hand[0].name && touchedNode.name != "background" && touchedNode.name != "MainGuy" && isPlacement == false && isPlayed == false){
        
        for place in Placement{
            
            if place != Placement[0] && place != Placement[1] && place != Placement[2]{
            if(
                (((touchedNode.position.x < place.position.x + (place.size.width/2))) && (touchedNode.position.y < place.position.y+(place.size.height/2))) &&
                (((touchedNode.position.x > place.position.x - (place.size.width/2)) && (touchedNode.position.y < place.position.y+(place.size.height/2)))) &&
                (((touchedNode.position.x < place.position.x + (place.size.width/2)) && (touchedNode.position.y > place.position.y-(place.size.height/2)))) &&
                (((touchedNode.position.x > place.position.x - (place.size.width/2)) && ((touchedNode.position.y > place.position.y-(place.size.height/2)))))
            
                ){
                touchedNode.position = place.position
                let currentNode = Hand.firstIndex(of: touchedNode)!
                
//                var currentPlayed = Bool()
//                var placementName = place.name
//                var placementNum = placementName![(placementName?.endIndex)!]
                
                
                var playedNameHold  = "Played"
                var foundNode: SKSpriteNode?
                playedNameHold.append(place.name!.last!)
                
                for n in Played{
                    if n.name == playedNameHold{
                        foundNode = n
                    }
                }
                
                if foundNode != nil{
                    scene.removeChildren(in: [scene.childNode(withName: foundNode!.name!)!])
                    Played.remove(at: Played.firstIndex(of: foundNode!)!)
                }
                
                Played.append(Hand[currentNode])
                Played[Played.count-1].size = place.size
                Played[Played.count-1].zPosition = place.zPosition
                Played[Played.count-1].lightingBitMask = 1
                
                
                
                Played[Played.count-1].name = playedNameHold
                Hand.remove(at: currentNode)
                colorName -= 1
                if colorName != 0{
                for i in 1...Hand.count-1{
                    Hand[i].name = "color\(i)"
                }
                }
                }
            }
        }
    }
}


func redrawPlayerHand(Hand: inout [SKSpriteNode],HandTextureAtlas: inout SKTextureAtlas, stackNum: Int, colorName: inout Int, colorNum:  [Int], didPlayerRedraw: inout Bool) -> Int{
    
    var currentNumOfCardsToBeRedrawn = Hand.count-1
    
    if didPlayerRedraw == false{
        
        
       
        didPlayerRedraw = true
    }
    return currentNumOfCardsToBeRedrawn
    
}

func placeCardsInHand(Hand: inout [SKSpriteNode]){
    if(Hand.count >= 2){
        for card in Hand{
            if(card != Hand[0]){
                card.scale(to: CGSize(width: 162, height: 299))
                card.zPosition = 4
                let currentCard = Hand.firstIndex(of: card)!
                let moveToHand = SKAction .move(to: CGPoint(x:125 + (-50 * ((Hand.count-1) - currentCard)), y:-475), duration: 0.1)
                //  let shrink = SKAction .resize(toWidth: (CGFloat(262 / ((Hand.count)))), height: (399), duration: 0.1)
                card.run(moveToHand)
                //     card.run(shrink)
                print(card.position)
                
            }
            card.lightingBitMask = 1
        }
        
    }
}


func createCard(Hand: inout [SKSpriteNode], HandTextureAtlas: inout SKTextureAtlas, stackNum: Int, colorName: inout Int, colorNum: [Int] ){
    
    var validNum = Int.random(in: 0...colorNum.count)
    
    while validNum == stackNum{
        validNum = Int.random(in: 0...colorNum.count)
    }
    
    Hand.append(SKSpriteNode(imageNamed: HandTextureAtlas.textureNames[validNum]))
    Hand[Hand.count-1].size = CGSize(width: 216, height: 399)
    var newXposition = Hand[0].position.x - 107
    var newYposition = Hand[0].position.y
    Hand[Hand.count-1].position = CGPoint(x: newXposition,
                                          y: newYposition)
    stackToHand(Hand: &Hand)
    Hand[Hand.count-1].zPosition = 4
    Hand[Hand.count-1].shadowedBitMask = 1
    Hand[Hand.count-1].shadowCastBitMask = 0
    Hand[Hand.count-1].lightingBitMask = 1
    Hand[Hand.count-1].name = "color\(Hand.count-1)"
    colorName += 1
    Hand[Hand.count-1].isUserInteractionEnabled = false
}

func startHand(GeneralHand: inout [SKSpriteNode], GameScene: inout GameScene, HandTextureAtlas: inout SKTextureAtlas, stackNum: Int, colorName: inout Int, colorNum: [Int]){
    
    for i in 0...4{
        createCard(Hand: &GeneralHand, HandTextureAtlas: &HandTextureAtlas, stackNum: stackNum, colorName: &colorName, colorNum: colorNum)
        GameScene.addChild(GeneralHand[GeneralHand.count-1])
    }
    placeCardsInHand(Hand: &GeneralHand)
    
}

func drawCardsforHand(GeneralHand: inout [SKSpriteNode], GameScene: inout GameScene, HandTextureAtlas: inout SKTextureAtlas, stackNum: Int, colorName: inout Int, colorNum: [Int], numOfCardsToDraw: Int){
    
    for i in 1...numOfCardsToDraw{
        createCard(Hand: &GeneralHand, HandTextureAtlas: &HandTextureAtlas, stackNum: stackNum, colorName: &colorName, colorNum: colorNum)
        GameScene.addChild(GeneralHand[GeneralHand.count-1])
    }
    placeCardsInHand(Hand: &GeneralHand)
    
}

func calculatePlayedCards(Played: [SKSpriteNode], HandTextureAtlas: inout SKTextureAtlas){
    
    // RED > GREEN
    // GREEN > BLUE
    // BLUE > RED
    // BLACK > RED > GREEN > BLUE
    //
    // WHITE > BLACK
    // RED > GREEN > BLUE > WHITE
    
    var cardColors = [String]()
    
    
    for i in 0...Played.count-1{
        switch Played[i].texture?.cgImage(){
        case HandTextureAtlas.textureNamed("Green_card.png").cgImage():
            cardColors.append("Green")
        case HandTextureAtlas.textureNamed("Blue_card.png").cgImage():
            cardColors.append("Blue")
        case HandTextureAtlas.textureNamed("Red_card.png").cgImage():
            cardColors.append("Red")
        case HandTextureAtlas.textureNamed("Black_card.png").cgImage():
            cardColors.append("Black")
        case HandTextureAtlas.textureNamed("White_card.png").cgImage():
            cardColors.append("White")
        
        default:
            cardColors.append("BROKE")
        }
        
        
    }
    
    
}
