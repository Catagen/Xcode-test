//
//  GameScene.swift
//  Boxxle
//
//  Created by Szymon Stypa on 2017-12-10.
//  Copyright © 2017 Szymon Stypa. All rights reserved.
//

import SpriteKit
import GameplayKit

class GameScene: SKScene {
    
    let bg = SKSpriteNode(imageNamed: ImageNames.background)
    let player = Agent(imageNamed: ImageNames.playerFront)
    
    let resetButton = SKSpriteNode(imageNamed: ImageNames.resetButton)
    
    let swipeRightRec = UISwipeGestureRecognizer()
    let swipeLeftRec = UISwipeGestureRecognizer()
    let swipeUpRec = UISwipeGestureRecognizer()
    let swipeDownRec = UISwipeGestureRecognizer()
    
    override func didMove(to view: SKView) {
        
        // Map setup
        let grphx = Graphics(scene: self, map: Maps.map1)
        grphx.generateMap()
        
        // Player setup
        player.setup(map: Maps.map1, scene: self)
        
        // Temporary reset button setup
        resetButton.position.x = self.size.width - (resetButton.size.width * 2)
        resetButton.position.y = resetButton.size.height
        resetButton.anchorPoint = CGPoint(x: 0, y: 0)
        resetButton.name = "resetButton"
        addChild(resetButton)
        
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
    
    func loadScene(fileNamed: String) {
        if let scene = SKScene(fileNamed: fileNamed) {
            // Set the scale mode to scale to fit the window
            scene.scaleMode = .aspectFill
            
            // Present the scene
            self.view!.presentScene(scene)
        }
    }
    
//------------------------------------------------------------------------------------------------------------------------------
    
    func touchDown(atPoint pos : CGPoint) {

    }
    
    func touchMoved(toPoint pos : CGPoint) {

    }
    
    func touchUp(atPoint pos : CGPoint) {
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        for t in touches {
            let location = t.location(in: self)
            let touchNode = atPoint(location)
            
            // If touch occured on reset button
            if touchNode.name == "resetButton"{
                loadScene(fileNamed: "GameScene")
            }
        }
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
