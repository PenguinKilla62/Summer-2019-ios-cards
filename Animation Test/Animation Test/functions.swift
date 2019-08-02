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

func checkIfCardPlayed(touchedNode: inout SKSpriteNode, Hand: inout [SKSpriteNode], Placement: inout [SKSpriteNode], Played: inout [SKSpriteNode], colorName: inout Int){
    
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
            if(
                (((touchedNode.position.x < place.position.x + (place.size.width/2))) && (touchedNode.position.y < place.position.y+(place.size.height/2))) &&
                (((touchedNode.position.x > place.position.x - (place.size.width/2)) && (touchedNode.position.y < place.position.y+(place.size.height/2)))) &&
                (((touchedNode.position.x < place.position.x + (place.size.width/2)) && (touchedNode.position.y > place.position.y-(place.size.height/2)))) &&
                (((touchedNode.position.x > place.position.x - (place.size.width/2)) && ((touchedNode.position.y > place.position.y-(place.size.height/2)))))
            
                ){
                touchedNode.position = place.position
                let currentNode = Hand.firstIndex(of: touchedNode)!
                Played.append(Hand[currentNode])
                Played[Played.count-1].size = place.size
                Played[Played.count-1].zPosition = place.zPosition
                Played[Played.count-1].lightingBitMask = 1
                Played[Played.count-1].name = "Played\(Played.count-1)"
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


func sortHand(Hand: inout[SKSpriteNode]){
    

}

func redrawPlayerHand(Hand: inout [SKSpriteNode],HandTextureAtlas: inout SKTextureAtlas, stackNum: Int, colorName: inout Int, colorNum:  [Int], didPlayerRedraw: inout Bool) -> Int{
    
    var currentNumOfCardsToBeRedrawn = Hand.count-1
    
    if didPlayerRedraw == false{
        
        
       
        didPlayerRedraw = true
    }
    return currentNumOfCardsToBeRedrawn
    
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
    Hand[Hand.count-1].name = "color\(colorName)"
    colorName += 1
    Hand[Hand.count-1].isUserInteractionEnabled = false
    sortHand(Hand: &Hand)
}

