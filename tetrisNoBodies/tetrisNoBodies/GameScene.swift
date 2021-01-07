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
    
    private var left: SKSpriteNode!
    private var right: SKSpriteNode!
    private var down: SKSpriteNode!
    
    private var rotateLeft: SKSpriteNode!
    private var rotateRight: SKSpriteNode!

    
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
        
        left = SKSpriteNode(texture: SKTexture(image: #imageLiteral(resourceName: "left")) , size: CGSize(width: 192, height: 192))
        left.position = CGPoint(x: -328, y: -800)
        left.zPosition = 11
        left.name = "Move Left"
        addChild(left)
        
        right = SKSpriteNode(texture: SKTexture(image: #imageLiteral(resourceName: "right")) , size: CGSize(width: 192, height: 192))
        right.position = CGPoint(x: 328, y: -800)
        right.zPosition = 11
        right.name = "Move Right"
        addChild(right)
        
        down = SKSpriteNode(texture: SKTexture(image: #imageLiteral(resourceName: "down")) , size: CGSize(width: 192, height: 192))
        down.position = CGPoint(x: 0, y: -800)
        down.zPosition = 11
        down.name = "Fast Down"
        addChild(down)
     
        
        rotateLeft = SKSpriteNode(texture: SKTexture(image: #imageLiteral(resourceName: "rotateLeft")) , size: CGSize(width: 192, height: 192))
        rotateLeft.position = CGPoint(x: 350, y: -500)
        rotateLeft.zPosition = 11
        rotateLeft.name = "Rotate Left"
        addChild(rotateLeft)
        
        rotateRight = SKSpriteNode(texture: SKTexture(image: #imageLiteral(resourceName: "rotateRight")) , size: CGSize(width: 192, height: 192))
        rotateRight.position = CGPoint(x: 350, y: -200)
        rotateRight.zPosition = 11
        rotateRight.name = "Rotate Right"
        addChild(rotateRight)

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
        guard let pos = touches.first?.location(in: self) else {
            return
        }
        
        let node = self.atPoint(pos)
        
        print(node.name ?? "No name")
        
        if node == left{
            board.movingTetro?.move(on: board, to: true)
        } else if node == right {
            board.movingTetro?.move(on: board, to: false)
        }
        else if node == down {
            fastDown = true
        }
        
        else if node == rotateLeft {
            board.rotateTetro(clockwise: true)
        }        else if node == rotateRight {
            board.rotateTetro(clockwise: false)
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
