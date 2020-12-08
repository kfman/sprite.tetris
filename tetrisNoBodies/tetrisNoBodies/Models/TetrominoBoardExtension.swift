//
//  Tetromino+Board+Extension.swift
//  tetrisNoBodies
//
//  Created by Klaus Fischer on 08.12.20.
//

import SpriteKit


extension Tetromino{
    func canDrop(on board: Board) -> Bool{
        var lowestTile: Int = 0
        for i in 0..<shape.count{
            if shape[i].contains(true){
                lowestTile = i
            }
        }
        /// Other tetro
        // TODO: find a good idea
        
        ///  Board edge
        return gridPosition.y >= lowestTile
    }
    
    func canRotate(on board: Board, clockwise: Bool) -> Bool{
        return true
    }
    
    func canMove(on board: Board, left: Bool) -> Bool{
        return true
    }
    
    func move(on board: Board, to left: Bool){
        run(SKAction.move(by: CGVector(dx: left ? CGFloat(-gridSize) : CGFloat(gridSize), dy: 0.0), duration: 0.3))
    }
    
    func rotate(on board: Board, clockwise: Bool){
        if !canRotate(on: board, clockwise: clockwise){ return }
        
        let angle: CGFloat = CGFloat((clockwise ? Double.pi / 2.0 : Double.pi / -2.0))
        run(SKAction.rotate(byAngle: angle, duration: 0.3))

    }
    
    func moveDown(on board: Board){
        if canDrop(on: board){
            self.gridPosition = GridPosition(x: gridPosition.x, y: gridPosition.y - 1)
            run(SKAction.move(by: CGVector(dx: 0, dy: -gridSize), duration: 0.3))
        }
        else{
            board.fixTetro(self)
        }
    }
}
