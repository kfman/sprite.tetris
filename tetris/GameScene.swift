//
//  GameScene.swift
//  tetris
//
//  Created by Klaus Fischer on 01.12.20.
//

import SpriteKit

class GameScene: SKScene {
    
    private var tetroFactory: Spawny!
    var movingBlock: Tetromino?
    
    override func didMove(to view: SKView) {
        
        tetroFactory = Spawny()
        
        let boardSize = SizeHelper.scale(from: frame.size, edge: SizeRef.height,
                                         scale: CGFloat(0.6))
        
        let board = Board(gridSize: CGSize(width: 10, height: 20), size: boardSize, fix: SizeRef.width)
        board.position = CGPoint(x:frame.width * 0.7, y: frame.height * 0.85)
        board.anchorPoint = CGPoint(x:0.0, y:1.0)
        board.zRotation = CGFloat(Double.pi)
        addChild(board)
        
        let block = Tetromino(type: TetrominoType.L, size: board.blockTileSize)
        block.position = CGPoint(x: 4, y: 4)
        board.addChild(block)
        
        let blockI = Tetromino(type: .I, size: board.blockTileSize)
        blockI.position = CGPoint(x: 4, y: 6)
        board.addChild(blockI)

        let blockO = Tetromino(type: .O, size: board.blockTileSize)
        blockO.position = CGPoint(x: 4, y: 8)
        board.addChild(blockO)

        movingBlock = blockO
     }

    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        if (touches.first?.location(in: self).x)! < frame.width / 4 {
            movingBlock?.stepLeft()
        } else if (touches.first?.location(in: self).x)! > frame.width * 0.75 {
            movingBlock?.stepRight()
        }
    }

    override func update(_ currentTime: TimeInterval) {
        // Called before each frame is rendered

    }
}
