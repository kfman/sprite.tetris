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
        
        
        super.init(texture: nil, color: UIColor.clear, size: size)
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
