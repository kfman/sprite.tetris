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
        let outLine = SKShapeNode(rectOf: tileSize)
        outLine.strokeColor = UIColor.black
        outLine.lineWidth = 1.0
        result.addChild(outLine)
        return result
    }

    init(type: TetrominoType, tileSize: CGSize, gridPosition: GridPosition) {
        self.tileSize = tileSize
        self.type = type
        self.gridPosition = gridPosition
        

        switch type {
        case .I:
            super.init(texture: nil, color: UIColor.clear, size: CGSize(width: tileSize.width * 4.0, height: tileSize.height))
            for i in 0...3 {
                let tile = getTile(color: UIColor.red)
                tile.position = CGPoint(x: CGFloat(i) * tileSize.width + tileSize.width / 2.0, y: tileSize.height / 2.0)
                addChild(tile)
            }
            physicsBody = SKPhysicsBody(rectangleOf: CGSize(width: tileSize.width * 4.0, height: tileSize.height),
                                        center: CGPoint(x: tileSize.width * 2.0, y: tileSize.height / 2.0))

        case .J:
            super.init(texture: nil, color: UIColor.clear, size: CGSize(width: tileSize.width * 3.0, height: tileSize.height * 2.0))
            for i in 0...3 {
                let tile = getTile(color: UIColor.blue)
                if i < 3 {
                    tile.position = CGPoint(x: CGFloat(i) * tileSize.width + tileSize.width / 2.0, y: 0.0 + tileSize.height / 2.0)
                } else {
                    tile.position = CGPoint(x: tileSize.width / 2.0, y: tileSize.height * 1.5)
                }
                addChild(tile)
            }
            
            
            let shape = CGMutablePath()
            shape.move(to: CGPoint(x:0.0, y: 0.0))
            shape.addLine(to: CGPoint(x: tileSize.width * 3.0 , y: 0.0))
            shape.addLine(to: CGPoint(x: tileSize.width * 3.0 , y: tileSize.height))
            shape.addLine(to: CGPoint(x: tileSize.width, y: tileSize.height))
            shape.addLine(to: CGPoint(x: tileSize.width, y: tileSize.height * 2.0))
            shape.addLine(to: CGPoint(x: 0.0, y: tileSize.height * 2.0))
            shape.closeSubpath()
            //shape.addLine(to: CGPoint(x: 0.0, y: 0.0))
            physicsBody = SKPhysicsBody(polygonFrom: shape)

        case .L:
            super.init(texture: nil, color: UIColor.clear, size: CGSize(width: tileSize.width * 3.0, height: tileSize.height * 2.0))
            for i in 0...3 {
                let tile = getTile(color: UIColor.green)
                if i < 3 {
                    tile.position = CGPoint(x: CGFloat(i) * tileSize.width + tileSize.width / 2.0, y: 0.0 + tileSize.height / 2.0)
                } else {
                    tile.position = CGPoint(x: tileSize.width / 2.0, y: -tileSize.height * 0.5)
                }
                addChild(tile)
            }
            
            
            let shape = CGMutablePath()
            shape.move(to: CGPoint(x:0.0, y: -tileSize.height))
            shape.addLine(to: CGPoint(x: tileSize.width, y: -tileSize.height))
            shape.addLine(to: CGPoint(x: tileSize.width, y: 0.0))
            shape.addLine(to: CGPoint(x: tileSize.width * 3.0, y: 0.0))
            shape.addLine(to: CGPoint(x: tileSize.width * 3.0, y: tileSize.height))
            shape.addLine(to: CGPoint(x: 0.0, y: tileSize.height))
            shape.closeSubpath()
            //shape.addLine(to: CGPoint(x: 0.0, y: 0.0))
            physicsBody = SKPhysicsBody(polygonFrom: shape)

        case .O:
            super.init(texture: nil, color: UIColor.clear, size: CGSize(width: tileSize.width * 2.0, height: tileSize.height * 2.0))
            for i in 0...3 {
                let tile = getTile(color: UIColor.yellow)

                tile.position = CGPoint(x: (CGFloat(i % 2) * tileSize.width) - tileSize.width / 2.0,
                                        y: (i < 2 ? 0.0 : 1.0 * tileSize.height) - tileSize.height / 2.0)
                addChild(tile)
            }
            physicsBody = SKPhysicsBody(rectangleOf: frame.size)

        default:
            super.init(texture: nil, color: UIColor.clear, size: CGSize(width: tileSize.width * 4.0, height: tileSize.height))
            physicsBody = SKPhysicsBody(rectangleOf: frame.size)
            break
        }
        anchorPoint = CGPoint(x: 0.0, y: 0.0)

        physicsBody!.affectedByGravity = false
        physicsBody!.allowsRotation = false
        physicsBody!.restitution = 1.0
        // physicsBody!.isDynamic = false

    }

    var stopped = false
    func moveDown() -> Bool {
        let oldPosition = self.position.y
        run(SKAction.moveBy(x: 0, y: -tileSize.height, duration: 0.2)){
            self.stopped = (oldPosition  - self.tileSize.height / 2) < self.position.y
        }
        
        return stopped
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
