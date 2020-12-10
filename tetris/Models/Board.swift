//
//  Board.swift
//  tetris
//
//  Created by Klaus Fischer on 01.12.20.
//

import SpriteKit

class Board: SKSpriteNode{
    
    let grid: [[Int]]
    let rows: Int
    let columns: Int
    
    private var _blockTileSize: CGSize!
    var blockTileSize: CGSize{
        get{ return _blockTileSize }
    }
    
    static func getBoardSize(size: CGSize, rows:Int, columns:Int, fix: SizeRef?)->CGSize{
        var optSize: CGSize
        if fix == SizeRef.width{
            optSize = CGSize(width: size.width, height: size.width * CGFloat(rows) / CGFloat(columns))
        }else if fix == SizeRef.height{
            optSize = CGSize(width: size.height * CGFloat(columns) / CGFloat(rows), height: size.height)
        }
        else {
            optSize = size
        }
        return optSize
    }
    
    
    init(size: CGSize, rows: Int, columns: Int) {
        self.rows = rows
        self.columns = columns
        grid = [[Int]](repeating: [Int](repeating: 0, count: columns), count: rows)
        
        super.init(texture:nil, color: UIColor.clear, size: size)
        anchorPoint = CGPoint(x: 0.0, y: 0.0)
        
        let pathToDraw: CGMutablePath = CGMutablePath()
        pathToDraw.addRect(frame)
        
        let shape = SKShapeNode(path: pathToDraw)
        shape.lineWidth = CGFloat(2.0)
        addChild(shape)
        
        
        let columnWidth = size.width / CGFloat(columns)
        let rowHeight = size.height / CGFloat(rows)
        
        _blockTileSize = CGSize(width: CGFloat(columnWidth), height: CGFloat(rowHeight))
        
        let dummy = SKSpriteNode(texture: nil, color: UIColor.red, size: CGSize(width: 10, height: 10))
        dummy.position = CGPoint(x: 0, y: 0)
        addChild(dummy)
        
        for i in 1..<columns{
            addChild(drawLine(x: CGFloat(i) * CGFloat(columnWidth) , y: 0, vertical: true))
        }
        
        for i in 1..<rows{
            addChild(drawLine(x: 0, y: CGFloat(i) * CGFloat(rowHeight), vertical: false))
        }

        physicsBody = SKPhysicsBody.init(edgeLoopFrom: frame)
        physicsBody!.restitution = 1.0
    }
    
    override func addChild(_ node: SKNode) {
        if node is Tetromino {
            let x = CGFloat((node as! Tetromino).gridPosition.x) * _blockTileSize.width
            let y = CGFloat((node as! Tetromino).gridPosition.y) * _blockTileSize.height
            node.position = CGPoint(x: x, y: y)
        }
        
        super.addChild(node)
    }
    
    func drawLine(x: CGFloat, y: CGFloat, vertical: Bool) -> SKShapeNode{
        let line =            vertical
            ? CGMutablePath(rect: CGRect(x: 0.0, y: 0.0, width: 1.0, height: size.height), transform: nil)
            : CGMutablePath(rect: CGRect(x: 0.0, y: 0.0, width: size.width, height: 1.0), transform: nil)
        
        var pointX, pointY: CGFloat
        if (vertical){
            pointY = 0
            pointX = x
            line.addLine(to: CGPoint(x:0, y:size.height))
        } else {
            pointY = y
            pointX = 0
            line.addLine(to: CGPoint(x:size.width, y:0))
        }
        
        let container = SKShapeNode(path: line)
        container.lineWidth = 0.8
        container.strokeColor = UIColor.white.withAlphaComponent(1.0)
        
        container.position = CGPoint(x: pointX ,
                                     y: pointY )
        return container

    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
