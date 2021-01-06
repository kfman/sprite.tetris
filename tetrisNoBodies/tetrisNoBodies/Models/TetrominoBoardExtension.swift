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
                print("DEBUG: Stopping: \(round(blockPosition.y)), board bottom")
                return false
            }
            
            if abs(targetPosition.x) > board.size.width * 0.5{
                return false
            }
            
            
            for child in board.children{
                
                if let cell = child as? SingleBlock{
                    let cellPosition = cell.position
                    
                    if (round(cellPosition.x) == targetPosition.x) && (round(cellPosition.y) == targetPosition.y){
                        print("DEBUG: Stopping block collision on \(round(cellPosition.x)):\(round(cellPosition.y))")
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
        if self.hasActions() {return false}
        
        let rotated = simulateRotation(on: board, clockwise: clockwise)
        
        for child in rotated{
            let blockPosition =  convert(child, to: board)
            if !board.isValidPosition(position: blockPosition){
                return false
            }
        }
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
    
    
    func simulateRotation(on board: Board, clockwise: Bool) -> [CGPoint] {
        let angle: CGFloat = CGFloat((clockwise ? Double.pi / 2.0 : Double.pi / -2.0))
        var result = [CGPoint]()
        for child in children{
            let originalPosition = child.position
            //let pivotPoint = position
            
            // X_new = -Y_old
            // Y_new = -X_old
            
            if angle > 0 {
                result.append(CGPoint(x: round(-originalPosition.y), y: round(originalPosition.x)))
            }
            else {
                result.append(CGPoint(x: round(originalPosition.y), y: round(-originalPosition.x)))
            }
        }
        return result
    }
    
    func rotate(on board: Board, clockwise: Bool){
        if !canRotate(on: board, clockwise: clockwise){ return }
        
        let angle: CGFloat = CGFloat((clockwise ? Double.pi / 2.0 : Double.pi / -2.0))
        // zRotation = zRotation + angle
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

extension Board {
    func isValidPosition(position: CGPoint) -> Bool{
        //print("DEBUG: Rotaion collision check on: \(round(position.x)):\(round(position.y)) against board \(round(self.size.width / 2))")
        if abs(position.x) > self.size.width / 2 { return false }
        
        if (abs(position.y) > self.size.height / 2) { return false }
        
        return isCellFree(position: position)
    }
    
    func isCellFree(position: CGPoint) -> Bool{
        for child in children{
            if (round(child.position.x) == round(position.x) && round(child.position.y) == round(position.y)) {return false}
        }
        return true
    }
}
