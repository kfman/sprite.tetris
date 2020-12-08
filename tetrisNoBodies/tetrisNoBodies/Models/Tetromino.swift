//
//  Tetromino.swift
//  tetrisNoBodies
//
//  Created by Klaus Fischer on 04.12.20.
//

import SpriteKit

enum TetrominoType {
    case I, J, L, O, S, T, Z
}

struct GridPosition{
    var x: Int
    var y: Int
    
    init(x:Int, y: Int){
        self.x = x
        self.y = y
    }
}

class SingleBlock: SKSpriteNode{
    init(color: UIColor, position: CGPoint, gridSize: CGFloat){
        super.init(texture: nil, color: color, size: CGSize(width: gridSize, height: gridSize))
        self.position = position
        
        let frame = SKShapeNode(rect: CGRect(x: -gridSize * 0.5, y: -gridSize * 0.5, width: gridSize, height: gridSize))
        frame.strokeColor = UIColor.black
        frame.lineWidth = 2.5
        addChild(frame)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
}

class Tetromino: SKSpriteNode{
    
    static var board: Board!
    
    var shape: [[Bool]]
    let type: TetrominoType
    let gridSize: CGFloat
    
    var gridPosition: GridPosition!
    
    init( type: TetrominoType,
          gridSize: CGFloat? = nil
    ){
        self.type = type
        self.gridSize = gridSize ?? Tetromino.board.gridSize
        self.shape = Tetromino.shapeForType(type: type)
        
        super.init(texture: nil, color: UIColor.clear, size: CGSize(width: self.gridSize * 4.0, height: self.gridSize * 4.0))
        drawSprite()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    static func rotate(shape: [[Bool]], clockwise: Bool) -> [[Bool]]{
        return shape
    }
    
    func createSingleBlock(color: UIColor, position: CGPoint) -> SKSpriteNode{
        return SingleBlock(color: color, position: position, gridSize: gridSize)
    }
    
    func drawSprite(){
        switch (type){
        case .O:
            addChild(createSingleBlock(color: UIColor.yellow, position: CGPoint(x: gridSize / 2.0, y: gridSize / 2.0)))
            addChild(createSingleBlock(color: UIColor.yellow, position: CGPoint(x: -gridSize / 2.0, y: gridSize / 2.0)))
            addChild(createSingleBlock(color: UIColor.yellow, position: CGPoint(x: gridSize / 2.0, y: -gridSize / 2.0)))
            addChild(createSingleBlock(color: UIColor.yellow, position: CGPoint(x: -gridSize / 2.0, y: -gridSize / 2.0)))
        case .I:
            addChild(createSingleBlock(color: UIColor.green, position: CGPoint(x: -gridSize * 1.5, y: gridSize / 2.0)))
            addChild(createSingleBlock(color: UIColor.green, position: CGPoint(x: -gridSize * 0.5, y: gridSize / 2.0)))
            addChild(createSingleBlock(color: UIColor.green, position: CGPoint(x: gridSize * 0.5, y: gridSize / 2.0)))
            addChild(createSingleBlock(color: UIColor.green, position: CGPoint(x: gridSize * 1.5, y: gridSize / 2.0)))
        case .J:
            addChild(createSingleBlock(color: UIColor.blue, position: CGPoint(x: -gridSize * 1.5, y: gridSize / 2.0)))
            addChild(createSingleBlock(color: UIColor.blue, position: CGPoint(x: -gridSize * 0.5, y: gridSize / 2.0)))
            addChild(createSingleBlock(color: UIColor.blue, position: CGPoint(x: gridSize * 0.5, y: gridSize / 2.0)))
            addChild(createSingleBlock(color: UIColor.blue, position: CGPoint(x: gridSize * 0.5, y: -gridSize / 2.0)))
        case .L:
            addChild(createSingleBlock(color: UIColor.red, position: CGPoint(x: -gridSize / 2.0, y: gridSize / 2.0)))
            addChild(createSingleBlock(color: UIColor.red, position: CGPoint(x: -gridSize / 2.0, y: -gridSize / 2.0)))
            addChild(createSingleBlock(color: UIColor.red, position: CGPoint(x: gridSize / 2.0, y: gridSize / 2.0)))
            addChild(createSingleBlock(color: UIColor.red, position: CGPoint(x: gridSize * 1.5, y: gridSize / 2.0)))
        case .S:
            addChild(createSingleBlock(color: UIColor.orange, position: CGPoint(x: -gridSize / 2.0, y: -gridSize / 2.0)))
            addChild(createSingleBlock(color: UIColor.orange, position: CGPoint(x: gridSize / 2.0, y: -gridSize / 2.0)))
            addChild(createSingleBlock(color: UIColor.orange, position: CGPoint(x: gridSize / 2.0, y: gridSize / 2.0)))
            addChild(createSingleBlock(color: UIColor.orange, position: CGPoint(x: gridSize * 1.5, y: gridSize / 2.0)))
        case .Z:
            addChild(createSingleBlock(color: UIColor.purple, position: CGPoint(x: -gridSize * 1.5, y: gridSize / 2.0)))
            addChild(createSingleBlock(color: UIColor.purple, position: CGPoint(x: -gridSize / 2.0, y: gridSize / 2.0)))
            addChild(createSingleBlock(color: UIColor.purple, position: CGPoint(x: -gridSize / 2.0, y: -gridSize / 2.0)))
            addChild(createSingleBlock(color: UIColor.purple, position: CGPoint(x: gridSize / 2.0, y: -gridSize / 2.0)))
        case .T:
            addChild(createSingleBlock(color: UIColor.magenta, position: CGPoint(x: -gridSize * 1.5, y: gridSize / 2.0)))
            addChild(createSingleBlock(color: UIColor.magenta, position: CGPoint(x: -gridSize / 2.0, y: gridSize / 2.0)))
            addChild(createSingleBlock(color: UIColor.magenta, position: CGPoint(x: -gridSize / 2.0, y: -gridSize / 2.0)))
            addChild(createSingleBlock(color: UIColor.magenta, position: CGPoint(x: gridSize / 2.0, y: gridSize / 2.0)))
        }
    }
    
    static func shapeForType(type: TetrominoType) -> [[Bool]]{
        
        switch (type) {
        case .O:
            return [
                [false, false, false, false],
                [false,  true,  true, false],
                [false,  true,  true, false],
                [false, false, false, false]]
            
        case .I:
            return [
                [false, false, false, false],
                [ true,  true,  true,  true],
                [false, false, false, false],
                [false, false, false, false]]
            
        case .L:
            return [
                [false, false, false, false],
                [false,  true, false, false],
                [false,  true, false, false],
                [false,  true,  true, false]]
            
        case .J:
            return [
                [false, false, false, false],
                [false, false,  true, false],
                [false, false,  true, false],
                [false,  true,  true, false]]
            
        case .T:
            return [
                [false, false, false, false],
                [false,  true, false, false],
                [ true,  true,  true, false],
                [false, false, false, false]]
            
        case .S:
            return [
                [false, false, false, false],
                [false,  true,  true, false],
                [ true,  true, false, false],
                [false, false, false, false]]
            
        case .Z:
            return [
                [false, false, false, false],
                [false,  true,  true, false],
                [false, false,  true,  true],
                [false, false, false, false]]
        }
    }
    
}
