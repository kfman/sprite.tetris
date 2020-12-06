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
    let gridSize: CGFloat
    let gridColor: UIColor = UIColor.gray
    
    let fields: [[Bool]]
    var tetros: [Tetromino] = [Tetromino]()
    var movingTetro: Tetromino?
    let spawny: Spawner
    
    
    init(rows: Int, columns: Int, gridSize: CGFloat) {
        self.rows = rows
        self.columns = columns
        self.gridSize = gridSize
        self.spawny = Spawner()
        
        fields = [[Bool]](repeating: [Bool](repeating: false, count: columns), count: rows)
        super.init(texture: nil,
                   color: UIColor.clear,
                   size: CGSize(width: gridSize * CGFloat(columns), height: gridSize * CGFloat(rows)))
        

        drawGrid()

        let center = SKSpriteNode(texture: nil, color: UIColor.red, size: CGSize(width: 15, height: 15))
        addChild(center)
        Tetromino.board = self
        
        addChild(spawny.tetrominoFactory())
    }
    
    func drawGrid(){
        
        for i in 0...columns{
            let line = CGMutablePath()
            line.move(to: CGPoint(x:0,y:0))
            line.addLine(to: CGPoint(x: 0, y: size.height))
            
            let node = SKShapeNode(path: line)
            node.strokeColor = gridColor
            node.lineWidth = 5.0
            node.position = CGPoint(x: -size.width / 2 + CGFloat(i) * gridSize, y: -size.height / 2)
            
            addChild(node)
        }
        
        for i in 0...rows{
            let line = CGMutablePath()
            line.move(to: CGPoint(x:0,y:0))
            line.addLine(to: CGPoint(x: size.width, y: 0))
            
            let node = SKShapeNode(path: line)
            node.strokeColor = gridColor
            node.lineWidth = 5.0
            node.position = CGPoint(x: -size.width / 2 , y: -size.height / 2 + CGFloat(i) * gridSize)
            
            addChild(node)
        }
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
