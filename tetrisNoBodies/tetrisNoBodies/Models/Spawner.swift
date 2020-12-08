//
//  Spawner.swift
//  tetrisNoBodies
//
//  Created by Klaus Fischer on 06.12.20.
//

import SpriteKit

class Spawner{
    
    func tetrominoFactory() -> Tetromino{
        return Tetromino(type: .T)
    }
    
}
