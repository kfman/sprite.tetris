//
//  Spawner.swift
//  tetrisNoBodies
//
//  Created by Klaus Fischer on 06.12.20.
//

import SpriteKit

class Spawner{
    
    static func getTetromino(int: Int) -> TetrominoType{
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

    
    func tetrominoFactory() -> Tetromino{
        let next = Int.random(in: 0...6)

        return Tetromino(type: Spawner.getTetromino(int: next))
    }
    
}
