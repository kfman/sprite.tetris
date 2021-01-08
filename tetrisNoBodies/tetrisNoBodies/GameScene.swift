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
    private var highScoreLabel: SKLabelNode!
    private var spawny: Spawner!
    
    private var pausedScreen: SKSpriteNode!

    
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
            gameOverLabel.zPosition = 15
            self.addChild(gameOverLabel)
            if UserDefaults.standard.integer(forKey: "HighScore") < self.lineCount
            {UserDefaults.standard.setValue(self.lineCount, forKey: "HighScore")}
        })
        addChild(board)
        addChild(spawny)
        board.position = CGPoint(x: -128, y: 82)
        addLabels()
        addButtons()
    }

    private func addLabels() {
        lineLabel = SKLabelNode(fontNamed: "Russo One")
        lineLabel.color = .white
        lineLabel.fontSize = 36
        lineLabel.zPosition = 10
        lineLabel.text = "Line count: \(self.lineCount)"
        lineLabel.position = CGPoint(x: size.width * -0.37, y: size.height * 0.48)
        addChild(lineLabel)
        lineCount = 0
        state = .idle

        highScoreLabel = SKLabelNode(fontNamed: "Russo One")
        highScoreLabel.color = .white
        highScoreLabel.fontSize = 36
        highScoreLabel.zPosition = 10
        let highScore = UserDefaults.standard.value(forKey: "HighScore") ?? 0
        highScoreLabel.text = "High Score: \(highScore)"
        highScoreLabel.position = CGPoint(x: size.width * 0.3, y: size.height * 0.48)
        addChild(highScoreLabel)
    }

    private func addButtons() {
        addButton(image: #imageLiteral(resourceName: "left"), position: CGPoint(x: -328,y: -800), name: leftButton)
        addButton(image: #imageLiteral(resourceName: "right"), position: CGPoint(x: 328,y: -800), name: rightButton)
        addButton(image: #imageLiteral(resourceName: "down"), position: CGPoint(x: 0,y: -800), name: downButton)
        addButton(image: #imageLiteral(resourceName: "rotateLeft"), position: CGPoint(x: 350,y: -500), name: rotateLeftButton)
        addButton(image: #imageLiteral(resourceName: "rotateRight"), position: CGPoint(x: 350,y: -200), name: rotateRightButton)
        addButton(image: #imageLiteral(resourceName: "pause"), position: CGPoint(x: 350,y: 200), name: pauseButton)
    }

    private func addButton(image: UIImage, position: CGPoint, name: String?) {
        let button = SKSpriteNode(texture: SKTexture(image: image) , size: CGSize(width: 192, height: 192))
        button.position = position
        button.zPosition = 11
        button.name = name
        addChild(button)
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
        
        if node.name == leftButton{
            board.movingTetro?.move(on: board, to: true)
        } else if node.name == rightButton {
            board.movingTetro?.move(on: board, to: false)
        }
        else if node.name == downButton {
            fastDown = true
        }
        else if node.name == rotateLeftButton {
            board.rotateTetro(clockwise: true)
        }
        else if node.name == rotateRightButton {
            board.rotateTetro(clockwise: false)
        }
        else if node.name == pauseButton{
            isPaused = true
            pausedScreen = SKSpriteNode(texture: SKTexture(image: #imageLiteral(resourceName: "Paused Screen")), color: UIColor.clear, size: CGSize(width: 1200, height: 1800))
            pausedScreen.position = CGPoint(x:0, y:0)
            pausedScreen.zPosition = 12
            addChild(pausedScreen)
        } else if node == pausedScreen {
            isPaused = false
            removeChildren(in: [pausedScreen])
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
