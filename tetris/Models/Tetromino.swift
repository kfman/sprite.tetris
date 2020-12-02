//
//  Tetromino.swift
//  tetris
//
//  Created by Klaus Fischer on 01.12.20.
//

import SpriteKit

enum TetrominoType {
    case I, J, L, O, S, T, Z
}

struct GridPosition{
    let x: Int
    let y: Int
    
    init(x: Int, y: Int){
        self.x = x
        self.y = y
    }
}

class Tetromino: SKSpriteNode {

    let type: TetrominoType
    let tileSize: CGSize
    let gridPosition: GridPosition

    func getTile(color: UIColor) -> SKSpriteNode {

        let result = SKSpriteNode(color: color, size: tileSize)



        return result
    }

    init(type: TetrominoType, size: CGSize, gridPosition: GridPosition) {
        self.tileSize = size
        self.type = type
        self.gridPosition = gridPosition

        switch type {
        case .I:
            super.init(texture: nil, color: UIColor.clear, size: CGSize(width: size.width * 4.0, height: size.height))
            for i in 0...3 {
                let tile = getTile(color: UIColor.red)
                tile.position = CGPoint(x: CGFloat(i) * size.width, y: 0.0)
                addChild(tile)
            }

        case .L:
            super.init(texture: nil, color: UIColor.clear, size: CGSize(width: size.width * 3.0, height: size.height * 2.0))
            for i in 0...3 {
                let tile = getTile(color: UIColor.blue)
                if i < 3 {
                    tile.position = CGPoint(x: CGFloat(i) * size.width, y: 0.0)
                } else {
                    tile.position = CGPoint(x: 0.0, y: -size.height)
                }
                addChild(tile)
            }

        case .O:
            super.init(texture: nil, color: UIColor.clear, size: CGSize(width: size.width * 2.0, height: size.height * 2.0))
            for i in 0...3 {
                let tile = getTile(color: UIColor.yellow)

                tile.position = CGPoint(x: (CGFloat(i % 2) * size.width) - tileSize.width / 2.0,
                                        y: (i < 2 ? 0.0 : 1.0 * size.height) - tileSize.height / 2.0)
                addChild(tile)
            }

        default:
            super.init(texture: nil, color: UIColor.clear, size: CGSize(width: size.width * 4.0, height: size.height))
            break
        }
        anchorPoint = CGPoint(x: 0.0, y: 0.0)

        physicsBody = SKPhysicsBody(rectangleOf: frame.size)
        physicsBody?.affectedByGravity = true
        physicsBody?.allowsRotation = false
        physicsBody?.restitution = 0.0

    }

    func stepLeft() {
        run(SKAction.moveBy(x: -tileSize.width, y: 0.0, duration: 0.2))
    }

    func stepRight() {
        run(SKAction.moveBy(x: tileSize.width, y: 0.0, duration: 0.2))
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}
