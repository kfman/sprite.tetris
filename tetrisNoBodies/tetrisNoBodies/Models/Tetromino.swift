//
//  Tetromino.swift
//  tetrisNoBodies
//
//  Created by Klaus Fischer on 04.12.20.
//

import SpriteKit

enum TetrominoType {
    case I, J, L, O, S, T, Z
}

struct GridPosition{
    var x: Int
    var y: Int
    
    init(x:Int, y: Int){
        self.x = x
        self.y = y
    }
}

class Tetromino: SKSpriteNode{
    
    var shape: [[Bool]]
    let type: TetrominoType
    
    var gridPosition: GridPosition
    
    init( type: TetrominoType,
          position: GridPosition,
          size: CGSize
    ){
        self.gridPosition = position
        self.type = type
        self.shape = Tetromino.shapeForType(type: type)
        
        super.init(texture: nil, color: UIColor.green, size: size)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    static func rotate(shape: [[Bool]], clockwise: Bool) -> [[Bool]]{
        return shape
    }
    
    static func shapeForType(type: TetrominoType) -> [[Bool]]{
        
        switch (type) {
        case .O:
            return [
                [false, false, false, false],
                [false,  true,  true, false],
                [false,  true,  true, false],
                [false, false, false, false]]
            
        case .I:
            return [
                [false, false, false, false],
                [ true,  true,  true,  true],
                [false, false, false, false],
                [false, false, false, false]]
            
        case .L:
            return [
                [false, false, false, false],
                [false,  true, false, false],
                [false,  true, false, false],
                [false,  true,  true, false]]
            
        case .J:
            return [
                [false, false, false, false],
                [false, false,  true, false],
                [false, false,  true, false],
                [false,  true,  true, false]]
            
        case .T:
            return [
                [false, false, false, false],
                [false,  true, false, false],
                [ true,  true,  true, false],
                [false, false, false, false]]
            
        case .S:
            return [
                [false, false, false, false],
                [false,  true,  true, false],
                [ true,  true, false, false],
                [false, false, false, false]]
            
        case .Z:
            return [
                [false, false, false, false],
                [false,  true,  true, false],
                [false, false,  true,  true],
                [false, false, false, false]]
        }
    }
    
}