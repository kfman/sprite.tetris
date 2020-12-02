//
//  Tetromino.swift
//  tetris
//
//  Created by Klaus Fischer on 01.12.20.
//

import SpriteKit

enum TetrominoType{
    case I, J, L, O, S, T, Z
}

class Tetromino : SKSpriteNode {
    
    let type: TetrominoType
        
    init(type: TetrominoType, size: CGSize) {

        self.type = type

        switch type {
        case .I:
            super.init(texture: nil, color: UIColor.clear, size: CGSize(width: size.width * 4.0, height: size.height))
            for i in 0...3 {
                let tile = SKSpriteNode(color: UIColor.red, size: size)
                tile.position = CGPoint(x: CGFloat(i) * size.width, y:0.0)
                addChild(tile)
            }
        
        case .L:
            super.init(texture: nil, color: UIColor.clear, size: CGSize(width: size.width * 3.0, height: size.height * 2.0))
            for i in 0...3 {
                let tile = SKSpriteNode(color: UIColor.blue, size: size)
                if i < 3 {
                tile.position = CGPoint(x: CGFloat(i) * size.width, y:0.0)
                }
                else {
                    tile.position = CGPoint(x: 0.0, y: -size.height)
                }
                addChild(tile)
            }

            
        default:
            super.init(texture: nil, color: UIColor.clear, size: CGSize(width: size.width * 4.0, height: size.height))
            break
        }
        anchorPoint = CGPoint(x:0.0,y:0.0)


    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
