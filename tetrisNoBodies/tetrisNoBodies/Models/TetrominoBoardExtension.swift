//
//  Tetromino+Board+Extension.swift
//  tetrisNoBodies
//
//  Created by Klaus Fischer on 08.12.20.
//

import SpriteKit


extension Tetromino{
    func canDrop(on board: Board) -> Bool{
        /// Other tetro
        for block in children{
            if !(block is SingleBlock){
                continue
            }
            
            let blockPosition = convert(block.position, to: board)
            let targetPosition = CGPoint(x:round(blockPosition.x), y: round(blockPosition.y - gridSize))
            
            if blockPosition.y < (board.size.height * -0.5) + gridSize * 1.5 {
                print("Stopping: \(round(blockPosition.y)), board bottom")
                return false
            }
            
            
            for child in board.children{
                if child == board.movingTetro{
                    continue
                }
                if let tetromino = child as? Tetromino{
                    
                    for tetChild in tetromino.children{
                        if let cell = tetChild as? SingleBlock{
                            let cellPosition = tetromino.convert(cell.position, to: board)
                            
                            if (round(cellPosition.x) == targetPosition.x) && (round(cellPosition.y) == targetPosition.y){
                                print("Stopping block collision on \(cellPosition.x):\(cellPosition.y)")
                                return false
                            }
                        }
                    }
                }
                
            }
            
        }
        return true
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
