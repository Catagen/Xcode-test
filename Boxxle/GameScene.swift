//
//  GameScene.swift
//  Boxxle
//
//  Created by Szymon Stypa on 2017-12-10.
//  Copyright © 2017 Szymon Stypa. All rights reserved.
//

import SpriteKit
import GameplayKit

var tiles = [tile]()

struct tile {
    var n:Int
    var x:CGFloat
    var y:CGFloat
    var type:Int
    var walkable:Bool
    
    static func getTile(num: Int) -> tile {
        return tiles[num]
    }
}

class GameScene: SKScene {
    
    let player = Agent(imageNamed: "char_front.png")
    
    let swipeRightRec = UISwipeGestureRecognizer()
    let swipeLeftRec = UISwipeGestureRecognizer()
    let swipeUpRec = UISwipeGestureRecognizer()
    let swipeDownRec = UISwipeGestureRecognizer()
    
    override func didMove(to view: SKView) {
        
        // Map setup
        let grphx = Graphics(scene: self)
        grphx.loadMap(map: Maps.map1)
        grphx.generateMap()
        
        // Player setup
        player.setup(map: Maps.map1, size: self.size)
        addChild(player)
        
        
        // Swipe recognition setup
        swipeRightRec.addTarget(self, action: #selector(GameScene.swipedRight) )
        swipeRightRec.direction = .right
        self.view!.addGestureRecognizer(swipeRightRec)
        
        swipeLeftRec.addTarget(self, action: #selector(GameScene.swipedLeft) )
        swipeLeftRec.direction = .left
        self.view!.addGestureRecognizer(swipeLeftRec)
        
        
        swipeUpRec.addTarget(self, action: #selector(GameScene.swipedUp) )
        swipeUpRec.direction = .up
        self.view!.addGestureRecognizer(swipeUpRec)
        
        swipeDownRec.addTarget(self, action: #selector(GameScene.swipedDown) )
        swipeDownRec.direction = .down
        self.view!.addGestureRecognizer(swipeDownRec)
        
    }
    
    @objc func swipedRight(sender:UISwipeGestureRecognizer){
        player.move(direction: 0)
    }
    
    @objc func swipedLeft(sender:UISwipeGestureRecognizer){
        player.move(direction: 2)
    }
    
    @objc func swipedUp(sender:UISwipeGestureRecognizer){
        player.move(direction: 1)
    }
    
    @objc func swipedDown(sender:UISwipeGestureRecognizer){
        player.move(direction: 3)
    }
    
//------------------------------------------------------------------------------------------------------------------------------
    
    func touchDown(atPoint pos : CGPoint) {

    }
    
    func touchMoved(toPoint pos : CGPoint) {

    }
    
    func touchUp(atPoint pos : CGPoint) {

    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
    }
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        for t in touches { self.touchMoved(toPoint: t.location(in: self)) }
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        for t in touches { self.touchUp(atPoint: t.location(in: self)) }
    }
    
    override func touchesCancelled(_ touches: Set<UITouch>, with event: UIEvent?) {
        for t in touches { self.touchUp(atPoint: t.location(in: self)) }
    }
    
    
    override func update(_ currentTime: TimeInterval) {
        // Called before each frame is rendered
    }
}
