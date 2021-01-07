//
//  Spawner.swift
//  tetrisNoBodies
//
//  Created by Klaus Fischer on 06.12.20.
//

import SpriteKit

class Spawner: SKSpriteNode{
    
    let gridColor: UIColor
    var nextTetromino: Tetromino
    
    private static func getTetromino(int: Int) -> TetrominoType{
        switch int {
        case 0: return TetrominoType.I
        case 1: return TetrominoType.J
        case 2: return TetrominoType.L
        case 3: return TetrominoType.O
        case 4: return TetrominoType.S
        case 5: return TetrominoType.T
        case 6: return TetrominoType.Z
        default: return TetrominoType.I
        }
    }

    
    init(size: CGSize, gridColor: UIColor = UIColor.gray) {
        self.gridColor = gridColor
        nextTetromino = Spawner.spawnTetromino()
        super.init(texture: nil, color: UIColor.clear, size: size)

        addChild(nextTetromino)
        
        let label = SKLabelNode(text: "Next block")
        label.position = CGPoint(x: 0, y: size.height/2 - 10)
        addChild(label)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    static private func spawnTetromino() -> Tetromino{
        let next = Int.random(in: 0...6)
        return Tetromino(type: getTetromino(int: next), gridSize: 40)
    }
    
    func tetrominoFactory() -> Tetromino{
        let result = Tetromino(type: nextTetromino.type)
        removeChildren(in: [nextTetromino])
        nextTetromino = Spawner.spawnTetromino()
        addChild(nextTetromino)
        return result
    }
}
