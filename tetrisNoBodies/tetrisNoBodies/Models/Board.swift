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
    
    let lineCallBack: (Int) -> Void
    let gameOverCallback: ()->Void
    
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
    
    init(rows: Int, columns: Int, gridSize: CGFloat,
         spawny: Spawner,
         lineDestroyed: @escaping (Int) -> Void,
         gameOver: @escaping ()->Void) {
        self.rows = rows
        self.columns = columns
        self.gridSize = gridSize
        self.spawny = spawny
        self.lineCallBack = lineDestroyed
        self.gameOverCallback = gameOver
        
        fields = [[Bool]](repeating: [Bool](repeating: false, count: columns), count: rows)
        super.init(texture: nil,
                   color: UIColor.clear,
                   size: CGSize(width: gridSize * CGFloat(columns), height: gridSize * CGFloat(rows)))
        
        
        drawGrid()
        //Tetromino.board = self
        spawn()
    }
    
    func spawn(){
        if !canSpawn(){
            gameOverCallback()
            return
        }
        movingTetro = spawny.tetrominoFactory()
        movingTetro?.position = initialPosition
        movingTetro?.gridPosition = initialGrid
        addChild(movingTetro!)
    }
    
    func canSpawn() -> Bool{
        for child in children{
            if let block = child as? SingleBlock{
                if block.position.y >= initialPosition.y{
                    return false
                }
            }
        }
        return true
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
        
        tetro.removeFromParent()
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
        
        
        var lines: Int = 0
        for row in 0..<rows{
            let yPosition = round(CGFloat(row) * gridSize * 0.5 - size.height * 0.5)
            let rowBlocks = blocks.keys.filter { (block) -> Bool in
                
                return (CGFloat(blocks[block] ?? Int.max) == yPosition)
            }
            
            if rowBlocks.count == columns{
                lines += 1
                rowBlocks.forEach { currentBlock in
                    currentBlock.run(SKAction.scale(by: 0.01, duration: 0.5)){
                        currentBlock.removeFromParent()
                    }
                }
                
                /// Move blocks above down
                let blocksAbove = blocks.keys.filter(){ CGFloat(blocks[$0] ?? Int.max) > yPosition}
                blocksAbove.forEach(){
                    $0.run(SKAction.move(by: CGVector(dx: 0, dy: -gridSize), duration: 0.3))
                }
            }
        }
        if lines > 0 {
            lineCallBack(lines)
            run(SKAction.playSoundFileNamed("lineVanish.mp3", waitForCompletion: false))
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


