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
    var singleBlocks: [SingleBlock] = [SingleBlock]()
    var movingTetro: Tetromino?
    let spawny: Spawner
    
    var initialPosition: CGPoint{
        get {
            return CGPoint(
                x: 0.0,
                y: gridSize * CGFloat(Int(rows / 2 - 2))
            )
        }
    }
    
    var initialGrid: GridPosition{
        get {
            return GridPosition(x: 0, y: rows - 2)
        }
    }
    
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
        spawn()
    }
    
    func spawn(){
        movingTetro = spawny.tetrominoFactory()
        movingTetro?.position = initialPosition
        movingTetro?.gridPosition = initialGrid
        addChild(movingTetro!)
    }
    
    func fixTetro(_ tetro: Tetromino){
        for child in tetro.children{
            if let block = child as? SingleBlock{
                let position = tetro.convert(block.position, to: self)
                block.position = position
                block.removeFromParent()
                addChild(block)
            }
        }
        
        movingTetro = nil
        clearLine()
        spawn()
    }
    
    func clearLine(){
        var blocks = Dictionary<SingleBlock, Int>()
        for tetroChild in children{
            
            if tetroChild is SingleBlock{
                let ypos = Int(round(tetroChild.position.y))
                blocks[(tetroChild as! SingleBlock)] = ypos
            }
        }
        
        
        
        for row in 0..<rows{
            let yPosition = round(CGFloat(row) * gridSize * 0.5 - size.height * 0.5)
            let rowBlocks = blocks.keys.filter { (block) -> Bool in
                
                return (CGFloat(blocks[block] ?? Int.max) == yPosition)
            }
            
            if rowBlocks.count == columns{
                rowBlocks.forEach { $0.removeFromParent()}
                
                /// Move blocks above down
                let blocksAbove = blocks.keys.filter(){ CGFloat(blocks[$0] ?? Int.max) > yPosition}
                blocksAbove.forEach(){
                    $0.run(SKAction.move(by: CGVector(dx: 0, dy: -gridSize), duration: 0.3))
                }
            }
        }
        
    }
    
    func dropTetromino() -> Bool{
        if (movingTetro == nil) {return true}
        if movingTetro!.hasActions(){
            return false
        }
        movingTetro?.moveDown(on: self)
        return true
    }
    
    func rotateTetro(){
        movingTetro?.rotate(on: self, clockwise: true)
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


