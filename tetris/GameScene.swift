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
        
        let optSize = Board.getBoardSize(size: boardSize, rows: 20, columns: 10, fix: SizeRef.width)
        
        let board = Board(size: optSize, rows: 20, columns: 10)
        board.position = CGPoint(x:frame.midX, y: frame.midY)
        addChild(board)
        
//        let block = Tetromino(type: TetrominoType.L, size: board.blockTileSize, gridPosition: GridPosition(x: 4, y: 4))
//        board.addChild(block)
//        
//        let blockI = Tetromino(type: .I, size: board.blockTileSize, gridPosition: GridPosition(x: 4, y: 6))
//        board.addChild(blockI)

        let blockO = Tetromino(type: .O, size: board.blockTileSize, gridPosition: GridPosition(x: 4, y: 2))
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
