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
        addChild(SKShapeNode(path: pathToDraw))
        
        
        var colum = size.width / gridSize.width
        var row = size.height / gridSize.height
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
