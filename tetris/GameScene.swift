//
//  GameScene.swift
//  tetris
//
//  Created by Klaus Fischer on 01.12.20.
//

import SpriteKit

class GameScene: SKScene {
    
    private var label : SKLabelNode?
    private var spinnyNode : SKShapeNode?
    
    override func didMove(to view: SKView) {
        
        let boardSize = SizeHelper.scale(from: frame.size, edge: SizeRef.height, scale: CGFloat(0.8))
        
        let board = Board(gridSize: CGSize(width: 10, height: 18), size: boardSize)
        board.position = CGPoint(x:frame.width * 0.1, y: frame.height * 0.1)
        addChild(board)
        
     }
    
    
    override func update(_ currentTime: TimeInterval) {
        // Called before each frame is rendered
    }
}
