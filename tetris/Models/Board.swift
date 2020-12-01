//
//  Board.swift
//  tetris
//
//  Created by Klaus Fischer on 01.12.20.
//

import SpriteKit

class Board: SKSpriteNode{
    
    init(gridSize: CGSize, size: CGSize) {
        super.init(texture:nil, color: UIColor.clear, size: size)
        let pathToDraw: CGMutablePath = CGMutablePath()
        pathToDraw.addRect(CGRect(x: 0, y: 0, width: size.width, height: size.height))
        
        let shape = SKShapeNode(path: pathToDraw)
        shape.lineWidth = CGFloat(2.0)
        addChild(shape)
        
        
        let columWidth = size.width / gridSize.width
        let rowHeight = size.height / gridSize.height
        
        for i in 1..<Int(gridSize.width){
            addChild(drawLine(x: CGFloat(i) * CGFloat(columWidth), y: 0))
        }
        
        for i in 1..<Int(gridSize.height){
            addChild(drawLine(x: 0, y: CGFloat(i) * CGFloat(rowHeight)))
        }
    }
    
    func drawLine(x: CGFloat, y: CGFloat) -> SKShapeNode{
        let line =
            y == 0
            ? CGMutablePath(rect: CGRect(x: 0.0, y:0.0, width: 1.0, height: size.height), transform: nil)
            : CGMutablePath(rect: CGRect(x: 0.0, y:0.0, width: size.width, height: 1.0), transform: nil)
        
        if (y == 0){
        line.addLine(to: CGPoint(x:0, y:size.height))
        } else{
            line.addLine(to: CGPoint(x:size.width, y:0))
        }
        
        let container = SKShapeNode(path: line)
        container.lineWidth = 1.0
        container.strokeColor = UIColor.white.withAlphaComponent(0.3)
        
        container.position = CGPoint(x: x, y: y)
        return container

    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
