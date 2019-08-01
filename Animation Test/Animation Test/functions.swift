//
//  functions.swift
//  Animation Test
//
//  Created by Sam Dillin on 8/1/19.
//  Copyright © 2019 Sam Dillin. All rights reserved.
//

import Foundation
import SpriteKit

func createCard(Hand: inout [SKSpriteNode], HandTextureAtlas: inout SKTextureAtlas, stackNum: Int, colorName: inout Int, colorNum: [Int] ){
    
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
    Hand[Hand.count-1].shadowedBitMask = 1
    Hand[Hand.count-1].shadowCastBitMask = 0
    Hand[Hand.count-1].lightingBitMask = 1
    Hand[Hand.count-1].name = "color\(colorName)"
    colorName += 1
    Hand[Hand.count-1].isUserInteractionEnabled = false
}
