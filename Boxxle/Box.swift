//
//  Box.swift
//  Boxxle
//
//  Created by Szymon Stypa on 2017-12-11.
//  Copyright © 2017 Szymon Stypa. All rights reserved.
//

import SpriteKit
import GameplayKit

var boxes = [Box]()

class Box: SKSpriteNode {
    
    var currentTileNr: Int = -1
    
    func setup(map: Array<Array<Int>>, scene: GameScene, tileNr: Int) {
        let currentTile = tile.getTile(num: tileNr)
        
        currentTileNr = tileNr
        zPosition = zPositions.box
        anchorPoint = CGPoint(x: 0, y: 0)
        size.width = scene.size.width / CGFloat(gameConfig.yDiff)
        position = CGPoint(x: currentTile.x, y: currentTile.y)
        
        currentTile.contain(node: self)
    }
    
    func move(direction: Int) -> Bool {
        let incr: Int
        
        switch direction {
        case 0:
            incr = gameConfig.xDiff
        case 1:
            incr = gameConfig.yDiff
        case 2:
            incr = -gameConfig.xDiff
        default:
            incr = -gameConfig.yDiff
        }
        
        let currentTile = tile.getTile(num: currentTileNr)
        let targetTile = tile.getTile(num: currentTileNr + incr)
        
        // If target tile is walkable
        if targetTile.walkable {
            
            // If target tile contains a box
            if (targetTile.contains as? Box) != nil {
                return false
            }

            // Make sure current tile contains nothing
            currentTile.contain(node: nil)
            
            // Move the player to target tile
            currentTileNr += incr
            targetTile.contain(node: self)
            
            let point = CGPoint(x: tile.getTile(num: currentTileNr).x, y: tile.getTile(num: currentTileNr).y)
            let move = SKAction.move(to: point, duration: gameConfig.moveAnimation)
            self.run(move)
            
            return true
            
        } else {
            return false
        }
    }
}
