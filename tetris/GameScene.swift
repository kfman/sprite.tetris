//
//  GameScene.swift
//  tetris
//
//  Created by Klaus Fischer on 01.12.20.
//

import SpriteKit

class GameScene: SKScene {
    
    private var tetroFactory: Spawny!
    
    override func didMove(to view: SKView) {
        
        tetroFactory = Spawny()
        
        let boardSize = SizeHelper.scale(from: frame.size, edge: SizeRef.height,
                                         scale: CGFloat(0.6))
        
        let board = Board(gridSize: CGSize(width: 10, height: 20), size: boardSize, fix: SizeRef.width)
        board.position = CGPoint(x:frame.width * 0.1, y: frame.height * 0.15)
        addChild(board)
        
     }
    
    
    override func update(_ currentTime: TimeInterval) {
        // Called before each frame is rendered
    }
}
