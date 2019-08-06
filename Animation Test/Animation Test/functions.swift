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

func checkIfCardPlayed(touchedNode: inout SKSpriteNode, Hand: inout [SKSpriteNode], scene: inout GameScene,Placement: inout [SKSpriteNode], Played: inout [SKSpriteNode], colorName: inout Int, HandColors: inout [String], PlayedColors: inout [String]){
    
//    var isPlacement = false
//    for i in 0...5{
//        if touchedNode.name == "Placement\(i)"{
//            isPlacement = true
//        }
//    }
//    
//    var isPlayed = false
//    for i in 0...(Played.count){
//        if touchedNode.name == "Played\(i)"{
//            isPlayed = true
//        }
//        
//    }
    
    var isHand = false
    for i in 1...Hand.count-1{
        
        if touchedNode.name == "color\(i)"{
            isHand = true
        }
    }
    
    if(touchedNode.name != Hand[0].name && isHand == true){
        
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
                var foundNodeIndexNum = Int()
                playedNameHold.append(place.name!.last!)
                
                for n in Played{
                    if n.name == playedNameHold{
                        foundNode = n
                    }
                }
                
                if foundNode != nil{
                    scene.removeChildren(in: [scene.childNode(withName: foundNode!.name!)!])
                    foundNodeIndexNum = Played.firstIndex(of: foundNode!)!
                    //Played.remove(at: foundNodeIndexNum)
                }
                else{
                    foundNodeIndexNum = Int(String(place.name!.last!))!
                }
                Played[foundNodeIndexNum] = Hand[currentNode]
                Played[foundNodeIndexNum].size = place.size
                Played[foundNodeIndexNum].zPosition = place.zPosition
                Played[foundNodeIndexNum].lightingBitMask = 1
                Played[foundNodeIndexNum].name = playedNameHold
                PlayedColors[foundNodeIndexNum] = HandColors[currentNode-1]
                Hand.remove(at: currentNode)
                HandColors.remove(at: currentNode-1)
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

func figureColorOfCard(HandtextureAtlas: inout SKTextureAtlas, validNum: Int, HandColors: inout [String]){
    
    switch HandtextureAtlas.textureNames[validNum]{
    case "Green_card.png":
        HandColors.append("Green")
    case "Blue_card.png":
        HandColors.append("Blue")
    case "Red_card.png":
        HandColors.append("Red")
    case "Black_card.png":
        HandColors.append("Black")
    case "White_card.png":
        HandColors.append("White")
        
    default:
        HandColors.append("BROKE")
    }
    
    
}


func createCard(Hand: inout [SKSpriteNode], HandTextureAtlas: inout SKTextureAtlas, stackNum: Int, colorName: inout Int, colorNum: [Int], HandColors: inout [String] ){
    
    var validNum = Int.random(in: 0...colorNum.count)
    
    while validNum == stackNum{
        validNum = Int.random(in: 0...colorNum.count)
    }
    
    Hand.append(SKSpriteNode(imageNamed: HandTextureAtlas.textureNames[validNum]))
    
    figureColorOfCard(HandtextureAtlas: &HandTextureAtlas, validNum: validNum, HandColors: &HandColors)
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

func startHand(GeneralHand: inout [SKSpriteNode], GameScene: inout GameScene, HandTextureAtlas: inout SKTextureAtlas, stackNum: Int, colorName: inout Int, colorNum: [Int], HandColors: inout [String]){
    
    for i in 0...4{
        createCard(Hand: &GeneralHand, HandTextureAtlas: &HandTextureAtlas, stackNum: stackNum, colorName: &colorName, colorNum: colorNum, HandColors: &HandColors)
        GameScene.addChild(GeneralHand[GeneralHand.count-1])
    }
    placeCardsInHand(Hand: &GeneralHand)
    
}

func drawCardsforHand(GeneralHand: inout [SKSpriteNode], GameScene: inout GameScene, HandTextureAtlas: inout SKTextureAtlas, stackNum: Int, colorName: inout Int, colorNum: [Int], numOfCardsToDraw: Int, HandColors: inout [String]){
    
    for i in 1...numOfCardsToDraw{
        createCard(Hand: &GeneralHand, HandTextureAtlas: &HandTextureAtlas, stackNum: stackNum, colorName: &colorName, colorNum: colorNum, HandColors: &HandColors)
        GameScene.addChild(GeneralHand[GeneralHand.count-1])
    }
    placeCardsInHand(Hand: &GeneralHand)
    
}

func calculatePlayedCards(Played: inout [SKSpriteNode], PlayedColors: inout [String]){
    
    // RED > GREEN
    // GREEN > BLUE
    // BLUE > RED
    // BLACK > RED > GREEN > BLUE
    //
    // WHITE > BLACK
    // (RED || GREEN || BLUE) > WHITE
    //
    // (BLACK || RED || GREEN || BLUE || WHITE) > NOTHING
    
    var cardColors = [String]()
    
    var laneWinnerNum = [Int]()
    
    for i in 0...2{
        
        switch PlayedColors[i]{
        case "Green":
            switch PlayedColors[i+3]{
            case "Green":
                laneWinnerNum.append(-1)
            case "Blue":
                laneWinnerNum.append(i)
            case "Red":
                laneWinnerNum.append(i+3)
            case "Black":
                laneWinnerNum.append(i+3)
            case "White":
                laneWinnerNum.append(i)
            case "":
                laneWinnerNum.append(i)
            default:
                laneWinnerNum.append(-1)
            }
        case "Blue":
            switch PlayedColors[i+3]{
            case "Green":
                laneWinnerNum.append(i+3)
            case "Blue":
                laneWinnerNum.append(-1)
            case "Red":
                laneWinnerNum.append(i)
            case "Black":
                laneWinnerNum.append(i+3)
            case "White":
                laneWinnerNum.append(i)
            case "":
                laneWinnerNum.append(i)
            default:
                laneWinnerNum.append(-1)
            }
        case "Red":
            switch PlayedColors[i+3]{
            case "Green":
                laneWinnerNum.append(i)
            case "Blue":
                laneWinnerNum.append(i+3)
            case "Red":
                laneWinnerNum.append(-1)
            case "Black":
                laneWinnerNum.append(i+3)
            case "White":
                laneWinnerNum.append(i)
            case "":
                laneWinnerNum.append(i)
            default:
                laneWinnerNum.append(-1)
            }
        case "Black":
            switch PlayedColors[i+3]{
            case "Green":
                laneWinnerNum.append(i)
            case "Blue":
                laneWinnerNum.append(i)
            case "Red":
                laneWinnerNum.append(i)
            case "Black":
                laneWinnerNum.append(-1)
            case "White":
                laneWinnerNum.append(i+3)
            case "":
                laneWinnerNum.append(i)
            default:
                laneWinnerNum.append(-1)
            }
        case "White":
            switch PlayedColors[i+3]{
            case "Green":
                laneWinnerNum.append(i+3)
            case "Blue":
                laneWinnerNum.append(i+3)
            case "Red":
                laneWinnerNum.append(i+3)
            case "Black":
                laneWinnerNum.append(i)
            case "White":
                laneWinnerNum.append(-1)
            case "":
                laneWinnerNum.append(i)
            default:
                laneWinnerNum.append(-1)
            }
        case "":
            switch PlayedColors[i+3]{
            case "Green":
                laneWinnerNum.append(i+3)
            case "Blue":
                laneWinnerNum.append(i+3)
            case "Red":
                laneWinnerNum.append(i+3)
            case "Black":
                laneWinnerNum.append(i+3)
            case "White":
                laneWinnerNum.append(i+3)
            case "":
                laneWinnerNum.append(-1)
            default:
                laneWinnerNum.append(-1)
            }
        default:
            laneWinnerNum.append(-1)
        }
        
    }
    
    
    
    
}
