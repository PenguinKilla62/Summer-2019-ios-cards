//
//  init_functions.swift
//  Animation Test
//
//  Created by Sam Dillin on 8/1/19.
//  Copyright © 2019 Sam Dillin. All rights reserved.
//

import Foundation
import SpriteKit

func initArrays( HandTextureArray: inout [SKTexture]){
    
    HandTextureArray.append(SKTexture(imageNamed: "Stack_card.png"))
    HandTextureArray.append(SKTexture(imageNamed: "Blue_card.png"))
    HandTextureArray.append(SKTexture(imageNamed: "Black_card.png"))
    HandTextureArray.append(SKTexture(imageNamed: "Red_card.png"))
    HandTextureArray.append(SKTexture(imageNamed: "Green_card.png"))
}

func initMainNodes(Background: inout SKSpriteNode, MainGuy:  inout SKSpriteNode, Hand: inout [SKSpriteNode], TextureAtlas: SKTextureAtlas, TextureAtlas1: SKTextureAtlas, HandTextureAtlas: SKTextureAtlas, stackNum: Int){
    
    MainGuy = SKSpriteNode(imageNamed: TextureAtlas.textureNames[0] )
    
    MainGuy.size = CGSize(width:200, height: 300)
    MainGuy.position = CGPoint(x: 0 , y: 0 )
    MainGuy.zPosition = 1
    MainGuy.name = "MainGuy"
    
    Background = SKSpriteNode(imageNamed: TextureAtlas1.textureNames[0] )
    
    Background.size = CGSize(width: 750, height: 1334)
    Background.position = CGPoint(x: 0, y: 0)
    Background.lightingBitMask = 0
    Background.shadowCastBitMask = 0
    Background.shadowedBitMask = 0
    Background.zPosition = -1
    Background.name = "background"
    
    Hand.append(SKSpriteNode(imageNamed: HandTextureAtlas.textureNames[stackNum]))
    
    Hand[0].size = CGSize(width: 216, height: 399)
    Hand[0].position = CGPoint(x: 275, y: -475)
    Hand[0].zPosition = 5
    Hand[0].name = "Stack"
}
