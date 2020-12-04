//
//  GameScene.swift
//  tetris
//
//  Created by Klaus Fischer on 01.12.20.
//

import SpriteKit

enum GameState {
    case idle, running, gameOver
}

class GameScene: SKScene {
    
    private var tetroFactory: Spawny!
    var movingBlock: Tetromino?
    var board: Board!
    
    var state: GameState = .idle
    
    override func didMove(to view: SKView) {
        
        
        let boardSize = SizeHelper.scale(from: frame.size, edge: SizeRef.height,
                                         scale: CGFloat(0.6))
        
        let optSize = Board.getBoardSize(size: boardSize, rows: 20, columns: 10, fix: SizeRef.width)
        
        board = Board(size: optSize, rows: 20, columns: 10)
        board.position = CGPoint(x:frame.midX, y: frame.midY)
        addChild(board)

        tetroFactory = Spawny(tetroSize: board.blockTileSize, gridPosition: GridPosition(x: 5, y: 1))

//        let block = Tetromino(type: TetrominoType.L, size: board.blockTileSize, gridPosition: GridPosition(x: 4, y: 4))
//        board.addChild(block)
//        
//        let blockI = Tetromino(type: .I, size: board.blockTileSize, gridPosition: GridPosition(x: 4, y: 6))
//        board.addChild(blockI)

        let blockO = Tetromino(type: .O, tileSize: board.blockTileSize, gridPosition: GridPosition(x: 5, y: 1))
        board.addChild(blockO)

        movingBlock = blockO
     }

    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        if state == .idle{
            state = .running
            return
        }
        
        if (touches.first?.location(in: self).x)! < frame.width / 4 {
            movingBlock?.stepLeft()
        } else if (touches.first?.location(in: self).x)! > frame.width * 0.75 {
            movingBlock?.stepRight()
        }
    }

    var lastMotion: Date = Date()
    
    override func update(_ currentTime: TimeInterval) {
        if state != .running{
            return
        }
        // Called before each frame is rendered
        guard movingBlock != nil else{
            lastMotion = Date()
            return
        }
        
        if (movingBlock!.stopped){
            movingBlock = tetroFactory.createTetromino()
            board.addChild(movingBlock!)
            return
        }
        
        if lastMotion.distance(to: Date() ) > TimeInterval.init(0.9){
            let stop = movingBlock!.moveDown()
            if stop {
                movingBlock = nil
            }
            lastMotion = Date()
        }
    }
}
