//
//  GameScene.swift
//  tetrisNoBodies
//
//  Created by Klaus Fischer on 04.12.20.
//

import SpriteKit
import GameplayKit

enum GameState {
    case idle, running, gameOver
}

class GameScene: SKScene {
    private var state: GameState = .idle
    private let moveInterval = TimeInterval(0.9)
    private var board: Board!
    private var fastDown: Bool = false
    
    override func didMove(to view: SKView) {
        self.board = Board(rows: 16, columns: 10, gridSize: 64.0)
        addChild(board)
    }
    
    func touchDown(atPoint pos : CGPoint) {
     }
    
    func touchMoved(toPoint pos : CGPoint) {
        
    }
    
    func touchUp(atPoint pos : CGPoint) {
        fastDown = false
        if state == .idle{
            state = .running
        }
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        guard let pos = touches.first?.location(in: board) else {
            return
        }
        
        if pos.x < (board.size.width * -0.25) {
            board.movingTetro?.move(on: board, to: true)
        } else if pos.x > (board.size.width * 0.25) {
            board.movingTetro?.move(on: board, to: false)
        } else if abs(pos.x) < board.size.width * 0.25 && (pos.y < 0.0){
            fastDown = true
        } else if pos.y > 0 {
            board.rotateTetro()
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
    
    
    var lastMovement = Date()
    override func update(_ currentTime: TimeInterval) {
        if state == .running{
            if (lastMovement.distance(to: Date()) > moveInterval && !fastDown)
                || (lastMovement.distance(to: Date()) > 0.1 && fastDown){

                if board.dropTetromino(){
                    lastMovement = Date()
                }
            }
        }
        // Called before each frame is rendered
    }
}
