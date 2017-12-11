//
//  Agent.swift
//  Boxxle
//
//  Created by Szymon Stypa on 2017-12-10.
//  Copyright © 2017 Szymon Stypa. All rights reserved.
//

import SpriteKit
import GameplayKit

class Agent: SKSpriteNode {
    
    var currentTileNr: Int = 0
    
    func setup(map: Array<Array<Int>>, size: CGSize) {
        
        let startTileNr = map[2][0]
        currentTileNr = startTileNr
        
        self.zPosition = 10
        self.size.width = size.width / 9
        self.anchorPoint = CGPoint(x: 0, y: -0.2)
        self.position = CGPoint(x: tile.getTile(num: startTileNr).x, y: tile.getTile(num: startTileNr).y)
    }
    
    // Move the agent in a direction
    func move(direction: Int) {
        let incr: Int
        let img: String
        
        switch direction {
        case 0:
            incr = gameConfig.xScale
            img = ImageNames.playerRight
        case 1:
            incr = gameConfig.yScale
            img = ImageNames.playerBack
        case 2:
            incr = -gameConfig.xScale
            img = ImageNames.playerLeft
        default:
            incr = -gameConfig.yScale
            img = ImageNames.playerFront
        }

        if tile.getTile(num: currentTileNr + incr).walkable {
            
            currentTileNr += incr
            
            let point = CGPoint(x: tile.getTile(num: currentTileNr).x, y: tile.getTile(num: currentTileNr).y)
            let move = SKAction.move(to: point, duration: gameConfig.moveAnimation)
            
            self.run(move)
        }
        
        self.texture = SKTexture(imageNamed: img)
    }
    
}
