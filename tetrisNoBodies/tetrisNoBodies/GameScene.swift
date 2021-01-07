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
    private var lineCount = 0
    private var lineLabel: SKLabelNode!
    private var spawny: Spawner!
    
    
    override func didMove(to view: SKView) {
        startAllOver()
    }
    
    func startAllOver(){
        spawny = Spawner(size: CGSize(width: 200, height: 200))
        spawny.position = CGPoint(x: 320, y: 550)
        spawny.zPosition = 10
        self.board = Board(rows: 24, columns: 10, gridSize: 64.0,
                           spawny: spawny,
                           lineDestroyed: { count in
            self.lineCount += count
            self.lineLabel.text = "Line count: \(self.lineCount)"
        }, gameOver: {
            self.state = .gameOver
            let gameOverLabel = SKLabelNode()
            gameOverLabel.attributedText = NSAttributedString(string: "Game Over", attributes: [
                .strokeWidth: -5,
                .font: UIFont(name: "Russo One", size: 90)!,
                .strokeColor: UIColor.black,
                .foregroundColor: UIColor.red
                //NSAttributedString.Key.backgroundColor: UIColor.red,
            ])
            // gameOverLabel.fontColor = .red
            gameOverLabel.zPosition = 1001
            self.addChild(gameOverLabel)
        })
        addChild(board)
        addChild(spawny)
        board.position = CGPoint(x: -128, y: 82)
        
        lineLabel = SKLabelNode(fontNamed: "Russo One")
        lineLabel.color = .white
        lineLabel.fontSize = 36
        lineLabel.zPosition = 1000
        lineLabel.text = "Line count: \(self.lineCount)"
        lineLabel.position = CGPoint(x: size.width * -0.37, y: size.height * 0.48)
        addChild(lineLabel)
        lineCount = 0
        state = .idle
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
        
        if state == .gameOver{
            removeAllChildren()
            startAllOver()
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
