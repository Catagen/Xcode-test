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
    
    func setup(map: Array<Array<Int>>, size: CGSize, tileNr: Int) {
        let currentTile = tile.getTile(num: tileNr)
        
        self.currentTileNr = tileNr
        self.zPosition = zPositions.box
        self.anchorPoint = CGPoint(x: 0, y: 0)
        self.size.width = size.width / CGFloat(gameConfig.yDiff)
        self.position = CGPoint(x: currentTile.x, y: currentTile.y)
        
        currentTile.contains = self
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
        
        // If target tile is walkable
        if tile.getTile(num: currentTileNr + incr).walkable {
            
            // If target tile contains a box
            if (tile.getTile(num: currentTileNr + incr).contains as? Box) != nil {
                return false
            }

            // Make sure current tile contains nothing
            tile.getTile(num: currentTileNr).contain(node: nil)
            
            // Update currentTile variables to match target tile
            currentTileNr += incr
            
            // Move the player to target tile
            tile.getTile(num: currentTileNr).contain(node: self)
            let point = CGPoint(x: tile.getTile(num: currentTileNr).x, y: tile.getTile(num: currentTileNr).y)
            let move = SKAction.move(to: point, duration: gameConfig.moveAnimation)
            self.run(move)
            
            return true
            
        } else {
            return false
        }
    }
}
