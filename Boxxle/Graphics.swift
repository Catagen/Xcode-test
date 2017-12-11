//
//  Graphics.swift
//  Boxxle
//
//  Created by Szymon Stypa on 2017-12-10.
//  Copyright © 2017 Szymon Stypa. All rights reserved.
//

import SpriteKit
import GameplayKit

class Graphics {
    
    let scene: GameScene
    
    init(scene: GameScene) {
        self.scene = scene
    }
    
    // Generate and configure SKSpriteNode from image name and position
    func generateSprite(ImageName: String, x:CGFloat, y:CGFloat, z: CGFloat = 0) {
        let sprite = SKSpriteNode(imageNamed: ImageName)
        
        sprite.zPosition = z
        sprite.position = CGPoint(x: x, y: y)
        sprite.anchorPoint = CGPoint(x: 0, y:0)
        sprite.size = CGSize(width: self.scene.size.width / CGFloat(gameConfig.yScale), height: self.scene.size.height / CGFloat(gameConfig.yScale * 2))
        
        self.scene.addChild(sprite)
    }
    
    // Look through the tiles array and apply appropriate sprites for every tile (by type)
    func generateMap() {
        for t in tiles {
            
            let sprite = SKLabelNode(text: "\(String(t.n)) \n \n \(String(t.walkable))")
            sprite.position.x = t.x
            sprite.position.y = t.y
            self.scene.addChild(sprite)
            
            if t.type == 1 {
                if !tile.getTile(num: t.n - gameConfig.yScale).walkable {
                    let bottomTile = tile.getTile(num: t.n - gameConfig.yScale)
                    generateSprite(ImageName: ImageNames.blockEdge, x: bottomTile.x, y: bottomTile.y)
                }
                
                generateSprite(ImageName: ImageNames.blockNormal, x: t.x, y: t.y)
                
            } else if t.type == 2 {
                if !tile.getTile(num: t.n - gameConfig.yScale).walkable {
                    let bottomTile = tile.getTile(num: t.n - gameConfig.yScale)
                    generateSprite(ImageName: ImageNames.blockEdge, x: bottomTile.x, y: bottomTile.y)
                }
                
                generateSprite(ImageName: ImageNames.blockSpecial, x: t.x, y: t.y)
            }
        }
    }
    
    // Divide the scene in to tiles (using tile struct) and append evey tile to self.tiles
    func loadMap(map: Array<Array<Int>>) {
        
        tiles.removeAll()
        
        for y in stride(from: 0, to: self.scene.size.height, by: self.scene.size.height / CGFloat(gameConfig.yScale * 2)) {
            for x in stride(from: 0, to: self.scene.size.width, by: self.scene.size.width / CGFloat(gameConfig.yScale)) {
                let n = tiles.count
                
                if map[0].contains(n) {
                    if map[1].contains(n) {
                        tiles.append(tile(n: n, x: x, y: y, type: 2, walkable: true))
                    } else {
                        tiles.append(tile(n: n, x: x, y: y, type: 1, walkable: true))
                    }
                } else {
                    tiles.append(tile(n: n, x: x, y: y, type: 0, walkable: false))
                }
            }
        }
        
    }
}
