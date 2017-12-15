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

    var currentTileNr: Int = -1

    func setup(map: Array<Array<Int>>, scene: GameScene) {
        
        // Set current tile number to spawn
        currentTileNr = map[2][0]
        
        // Get a reference to the spawn tile
        let currentTile = tile.getTile(num: currentTileNr)
        
        currentTile.contain(node: self)
        
        zPosition = zPositions.player
        anchorPoint = CGPoint(x: 0, y: -0.2)
        position = CGPoint(x: currentTile.x, y: currentTile.y)
        size.width = scene.size.width / CGFloat(gameConfig.yDiff)
        
        scene.addChild(self)
    }

    // Move the agent in a direction
    func move(direction: Int) {
        let incr: Int
        let img: String

        switch direction {
        case 0:
            incr = gameConfig.xDiff
            img = ImageNames.playerRight
        case 1:
            incr = gameConfig.yDiff
            img = ImageNames.playerBack
        case 2:
            incr = -gameConfig.xDiff
            img = ImageNames.playerLeft
        default:
            incr = -gameConfig.yDiff
            img = ImageNames.playerFront
        }
        
        self.texture = SKTexture(imageNamed: img)
        
        // If target tile is walkable
        if tile.getTile(num: currentTileNr + incr).walkable {
            
            // If new tile contains a box
            if let contained = tile.getTile(num: currentTileNr + incr).contains as? Box {
                
                // If box at target location is not movable
                if !contained.move(direction: direction) {
                    return
                }
            }
            
            // Make sure current tile contains nothing
            tile.getTile(num: currentTileNr).contain(node: nil)
            
            // Update currentTile variables to match target tile
            currentTileNr += incr
            
            // Move the player to target tile
            tile.getTile(num: currentTileNr).contain(node: self)
            let point = CGPoint(x: tile.getTile(num: currentTileNr).x, y: tile.getTile(num: currentTileNr).y)
            let move = SKAction.move(to: point, duration: gameConfig.moveAnimation)
            run(move)
            
        }
    }

}
