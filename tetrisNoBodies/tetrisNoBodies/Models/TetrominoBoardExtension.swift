//
//  Tetromino+Board+Extension.swift
//  tetrisNoBodies
//
//  Created by Klaus Fischer on 08.12.20.
//

import SpriteKit


extension Tetromino{
    
    func canMove(on board: Board, by: CGVector) -> Bool{
        if hasActions(){
            return false
        }
        
        for block in children{
            if !(block is SingleBlock){
                continue
            }
            
            let blockPosition = convert(block.position, to: board)
            let targetPosition = CGPoint(x:round(blockPosition.x + by.dx) , y: round(blockPosition.y + by.dy))
            
            if targetPosition.y < (board.size.height * -0.5) + gridSize * 0.5 {
                print("Stopping: \(round(blockPosition.y)), board bottom")
                return false
            }
            
            if abs(targetPosition.x) > board.size.width * 0.5{
                return false
            }
            
            
            for child in board.children{
                
                if let cell = child as? SingleBlock{
                    let cellPosition = cell.position
                    
                    if (round(cellPosition.x) == targetPosition.x) && (round(cellPosition.y) == targetPosition.y){
                        print("Stopping block collision on \(cellPosition.x):\(cellPosition.y)")
                        return false
                    }
                }
            }
            
        }
        
        
        return true
    }
    
    func canDrop(on board: Board) -> Bool{
        return canMove(on: board, by: CGVector(dx: 0, dy: -gridSize))
    }
    
    func canRotate(on board: Board, clockwise: Bool) -> Bool{
        return true
    }
    
    func canMove(on board: Board, left: Bool) -> Bool{
        return canMove(on: board, by:  CGVector(dx: left ? -gridSize : gridSize, dy: 0.0))
    }
    
    func move(on board: Board, to left: Bool){
        if (canMove(on: board, left: left)){
            run(SKAction.move(by: CGVector(dx: left ? CGFloat(-gridSize) : CGFloat(gridSize), dy: 0.0), duration: 0.15))
        }
    }
    
    func rotate(on board: Board, clockwise: Bool){
        if !canRotate(on: board, clockwise: clockwise){ return }
        
        let angle: CGFloat = CGFloat((clockwise ? Double.pi / 2.0 : Double.pi / -2.0))
        run(SKAction.rotate(byAngle: angle, duration: 0.15))
        
    }
    
    func moveDown(on board: Board){
        if canDrop(on: board){
            self.gridPosition = GridPosition(x: gridPosition.x, y: gridPosition.y - 1)
            run(SKAction.move(by: CGVector(dx: 0, dy: -gridSize), duration: 0.15))
        }
        else{
            board.fixTetro(self)
        }
    }
}

extension CGPoint {
    func onSameCell(other point: CGPoint, on board: Board) -> Bool{
        let gridSize = board.gridSize
        
        let column = Int(round(x / gridSize))
        let row = Int(round(y / gridSize))
        
        return column == Int(round(point.x / gridSize)) && row == Int(round(point.y / gridSize))
    }
}
