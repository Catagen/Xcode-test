//
//  Graphics.swift
//  Boxxle
//
//  Created by Szymon Stypa on 2017-12-10.
//  Copyright © 2017 Szymon Stypa. All rights reserved.
//

import SpriteKit
import GameplayKit

var tiles = [tile]()

class tile {
    var n:Int
    var x:CGFloat
    var y:CGFloat
    var type:Int
    var walkable:Bool
    var contains: SKSpriteNode?
    
    init(n: Int, x: CGFloat, y: CGFloat, type: Int, walkable: Bool = false) {
        self.n = n
        self.x = x
        self.y = y
        self.type = type
        self.walkable = walkable
    }
    
    static func getTile(num: Int) -> tile {
        return tiles[num]
    }
    
    func contain(node: SKSpriteNode?) {
        self.contains = node
    }
}

class Graphics {
    
    let scene: GameScene
    let map: Array<Array<Int>>
    let tileSize: CGSize
    
    init(scene: GameScene, map: Array<Array<Int>>) {
        self.scene = scene
        self.map = map
        
        let width = self.scene.size.width / CGFloat(gameConfig.yDiff)
        let height = self.scene.size.height / CGFloat(gameConfig.yDiff * 2)
        
        self.tileSize = CGSize(width: width, height: height)
        
        self.loadMap()
    }
    
    // Generate and configure SKSpriteNode from image name and position
    func generateSprite(ImageName: String, x:CGFloat, y:CGFloat, z: CGFloat = 0, size: CGSize? = nil) {
        let sprite = SKSpriteNode(imageNamed: ImageName)
        
        sprite.zPosition = z
        sprite.position = CGPoint(x: x, y: y)
        sprite.anchorPoint = CGPoint(x: 0, y:0)
        
        if let s = size {
            sprite.size = s
        } else {
            sprite.size = tileSize
        }
        
        self.scene.addChild(sprite)
    }
    
    // Look through the tiles array and apply appropriate sprites for types 1 & 2
    func generateMap() {
        
        // Load the background
        generateSprite(ImageName: ImageNames.background, x: 0, y: 0, z: zPositions.background, size: scene.size)
        
        // Add tile sprites
        for t in tiles {
            if t.type == 1 {
                if !tile.getTile(num: t.n - gameConfig.yDiff).walkable {
                    let bottomTile = tile.getTile(num: t.n - gameConfig.yDiff)
                    generateSprite(ImageName: ImageNames.blockEdge, x: bottomTile.x, y: bottomTile.y, z: zPositions.tile)
                }
                
                generateSprite(ImageName: ImageNames.blockNormal, x: t.x, y: t.y, z: zPositions.tile)
                
            } else if t.type == 2 {
                if !tile.getTile(num: t.n - gameConfig.yDiff).walkable {
                    let bottomTile = tile.getTile(num: t.n - gameConfig.yDiff)
                    generateSprite(ImageName: ImageNames.blockEdge, x: bottomTile.x, y: bottomTile.y, z: zPositions.tile)
                }
                
                generateSprite(ImageName: ImageNames.blockSpecial, x: t.x, y: t.y, z: zPositions.tile)
            }
            
            if map[3].contains(t.n) {
                let box = Box(imageNamed: ImageNames.box)
                box.setup(map: self.map, scene: self.scene, tileNr: t.n)
                tile.getTile(num: t.n).contain(node: box)
                scene.addChild(box)
            }
        }
    }
    
    // Divide the scene in to tiles and append evey tile to tiles array
    func loadMap() {
        
        tiles.removeAll()
        
        for y in stride(from: 0, to: scene.size.height, by: tileSize.height) {
            for x in stride(from: 0, to: self.scene.size.width, by: tileSize.width) {
                let n = tiles.count
                
                if map[0].contains(n) {
                    if map[1].contains(n) {
                        tiles.append(tile(n: n, x: x, y: y, type: 2, walkable: true))
                    } else {
                        tiles.append(tile(n: n, x: x, y: y, type: 1, walkable: true))
                    }
                } else {
                    tiles.append(tile(n: n, x: x, y: y, type: 0))
                }
            }
        }
        
    }
    
    // Debug function showing tile numbers
    func tileDubug() {
        for t in tiles {
            let label = SKLabelNode(text: String(t.n))
            
            label.horizontalAlignmentMode = .center
            label.verticalAlignmentMode = .center
            
            label.position = CGPoint(x: t.x, y: t.y)
            label.zPosition = 100
            
            scene.addChild(label)
        }
    }
}
