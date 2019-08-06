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

func initMainNodes(Background: inout SKSpriteNode, MainGuy:  inout SKSpriteNode, Hand: inout [SKSpriteNode], lightNode: inout SKLightNode, TextureAtlas: SKTextureAtlas, TextureAtlas1: SKTextureAtlas, HandTextureAtlas: SKTextureAtlas, stackNum: Int, playerHPLabelNode: inout SKLabelNode, playerHPLabelSpriteNode: inout SKSpriteNode, computerHPLabelNode: inout SKLabelNode, computerHPLabelSpriteNode: inout SKSpriteNode, roundLabelNode: inout SKLabelNode, roundLabelSpriteNode: inout SKSpriteNode){
    
    MainGuy = SKSpriteNode(imageNamed: TextureAtlas.textureNames[0] )
    
    MainGuy.size = CGSize(width:75, height: 125)
    MainGuy.position = CGPoint(x: 325 , y: 100 )
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
    
    Hand[0].size = CGSize(width: 216, height: 299)
    Hand[0].position = CGPoint(x: 275, y: -475)
    Hand[0].zPosition = 4
    Hand[0].name = "Stack"
    
    
    lightNode.isEnabled = false
    lightNode.zPosition = 3
    lightNode.categoryBitMask = 1
    lightNode.shadowColor = SKColor(red: 0.5, green: 0.5, blue: 0.5, alpha: 0.8)
    lightNode.lightColor = SKColor(red: 2, green: 2, blue: 2, alpha: 0.8)
    lightNode.ambientColor = SKColor(red: 0.6, green: 0.6, blue: 0.6, alpha: 0.07)
    lightNode.falloff = 0
    lightNode.name = "light"
    
    
    playerHPLabelNode = SKLabelNode(text: "5")
    playerHPLabelNode.fontSize = 300
    playerHPLabelNode.fontColor = .black
    playerHPLabelNode.position = CGPoint(x: 0,y: -playerHPLabelNode.frame.size.height/2)
    playerHPLabelNode.zPosition = 5
    playerHPLabelNode.name = "PLAYERHPLABEL"
    
    playerHPLabelSpriteNode = SKSpriteNode(color: .white, size: Hand[0].size)
    playerHPLabelSpriteNode.zPosition = 5
    playerHPLabelSpriteNode.position = Hand[0].position
    playerHPLabelSpriteNode.name = "PLAYERHPLABELSPRITENODE"
    [playerHPLabelSpriteNode .addChild(playerHPLabelNode)]
    
    computerHPLabelNode = SKLabelNode(text: "5")
    computerHPLabelNode.fontSize = 150
    computerHPLabelNode.fontName = "Times New Roman"
    computerHPLabelNode.fontColor = .black
    computerHPLabelNode.position = CGPoint(x: 0,y: -computerHPLabelNode.frame.size.height/2)
    computerHPLabelNode.zPosition = 5
    computerHPLabelNode.name = "COMPUTERHPLABEL"
    
    computerHPLabelSpriteNode = SKSpriteNode(color: .white, size: CGSize(width: 150, height:150))
    computerHPLabelSpriteNode.zPosition = 5
    computerHPLabelSpriteNode.position = CGPoint(x: -275, y:550)
    computerHPLabelSpriteNode.name = "COMPUTERHPLABELSPRITENODE"
    [computerHPLabelSpriteNode .addChild(computerHPLabelNode)]
    
    roundLabelNode = SKLabelNode(text: "1")
    roundLabelNode.fontSize = 75
    roundLabelNode.fontColor = .black
    roundLabelNode.position = CGPoint(x: 0, y: -roundLabelNode.frame.size.height/2)
    roundLabelNode.zPosition = 1
    roundLabelNode.name = "ROUNDLABEL"
    
    roundLabelSpriteNode  = SKSpriteNode(color: .white, size: CGSize(width: MainGuy.size.width, height: MainGuy.size.height))
    roundLabelSpriteNode.zPosition = 1
    roundLabelSpriteNode.position = CGPoint(x: MainGuy.position.x, y: MainGuy.position.y - 100)
    roundLabelSpriteNode.name = "ROUNDLABELSPRITENODE"
    [roundLabelSpriteNode .addChild(roundLabelNode)]
    
    
}


func initPlacement(Placement : inout [SKSpriteNode], PlacementTextureAtlas: inout SKTextureAtlas){
    
    var hold = 0
    
    while hold < 6{
        
        Placement.append(SKSpriteNode(imageNamed: PlacementTextureAtlas.textureNames[0]))
        Placement[Placement.count-1].size = CGSize(width: 162, height:299)
        Placement[Placement.count-1].shadowedBitMask = 0
        Placement[Placement.count-1].shadowCastBitMask = 0
        Placement[Placement.count-1].lightingBitMask = 1
        Placement[Placement.count-1].zPosition = 0
        Placement[Placement.count-1].isUserInteractionEnabled = false
        Placement[Placement.count-1].name = "Placement\(hold)"
        
        switch hold{
            
        case 0...2:
            Placement[Placement.count-1].position = CGPoint(x: (-200) + (200 * hold), y:300)
        case 3...5:
            Placement[Placement.count-1].position = CGPoint(x: (-200) + (200 * (hold - 3)), y:-100)
            
        default:
            Placement[Placement.count-1].position = CGPoint(x: 250,y: -450)
        }
        
        hold += 1
        
    }
    
}
