//
//  Board.swift
//  tetrisNoBodies
//
//  Created by Klaus Fischer on 04.12.20.
//

import SpriteKit

class Board: SKSpriteNode{
    
    let rows: Int
    let columns: Int
    
    let fields: [[Bool]]
    var tetros: [Tetromino] = [Tetromino]()
    var movingTetro: Tetromino?
    
    init(rows: Int, columns: Int, size:CGSize) {
        self.rows = rows
        self.columns = columns
        
        fields = [[Bool]](repeating: [Bool](repeating: false, count: columns), count: rows)
        super.init(texture: nil, color: UIColor.clear, size: size)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func update(){
        if movingTetro != nil{
            
        }
    }
    
}

extension Tetromino{
    func canDrop(board: Board) -> Bool{
        return true
    }
    
    func canRotate(board: Board, clockwise: Bool) -> Bool{
        return true
    }
    
    func canMove(board: Board, left: Bool) -> Bool{
        return true
    }
}
