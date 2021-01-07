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
    
    init(color: UIColor, position: CGPoint, gridSize: CGFloat, texture: SKTexture? = nil){
        super.init(texture: texture, color: color, size: CGSize(width: gridSize, height: gridSize))
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
    let type: TetrominoType
    let gridSize: CGFloat
    
    var gridPosition: GridPosition!
    
    init( type: TetrominoType,
          gridSize: CGFloat? = nil
    ){
        self.type = type
        self.gridSize = gridSize ?? 64
        
        super.init(texture: nil, color: UIColor.clear, size: CGSize(width: self.gridSize * 4.0, height: self.gridSize * 4.0))
        self.zPosition = 10
        drawSprite()
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    static func rotate(shape: [[Bool]], clockwise: Bool) -> [[Bool]]{
        return shape
    }
    
    func createSingleBlock(color: UIColor, position: CGPoint, texture: SKTexture? = nil) -> SKSpriteNode{
        return SingleBlock(color: color, position: position, gridSize: gridSize, texture: texture)
    }

    
    override func copy() -> Any {
        let result = Tetromino(type: type, gridSize: gridSize)
        result.position = position
        result.zRotation = zRotation
        return result
    }

    
    func drawSprite(){
        switch (type){
        case .O:
            addChild(createSingleBlock(color: UIColor.yellow, position: CGPoint(x: gridSize / 2.0, y: gridSize / 2.0), texture: SKTexture(image: #imageLiteral(resourceName: "YellowTile"))))
            addChild(createSingleBlock(color: UIColor.yellow, position: CGPoint(x: -gridSize / 2.0, y: gridSize / 2.0), texture: SKTexture(image: #imageLiteral(resourceName: "YellowTile"))))
            addChild(createSingleBlock(color: UIColor.yellow, position: CGPoint(x: gridSize / 2.0, y: -gridSize / 2.0), texture: SKTexture(image: #imageLiteral(resourceName: "YellowTile"))))
            addChild(createSingleBlock(color: UIColor.yellow, position: CGPoint(x: -gridSize / 2.0, y: -gridSize / 2.0), texture: SKTexture(image: #imageLiteral(resourceName: "YellowTile"))))
        case .I:
            addChild(createSingleBlock(color: UIColor.clear, position: CGPoint(x: -gridSize * 1.5, y: gridSize / 2.0), texture: SKTexture(image: #imageLiteral(resourceName: "GreenTile"))))
            addChild(createSingleBlock(color: UIColor.clear, position: CGPoint(x: -gridSize * 0.5, y: gridSize / 2.0), texture: SKTexture(image: #imageLiteral(resourceName: "GreenTile"))))
            addChild(createSingleBlock(color: UIColor.clear, position: CGPoint(x: gridSize * 0.5, y: gridSize / 2.0), texture: SKTexture(image: #imageLiteral(resourceName: "GreenTile"))))
            addChild(createSingleBlock(color: UIColor.clear, position: CGPoint(x: gridSize * 1.5, y: gridSize / 2.0), texture: SKTexture(image: #imageLiteral(resourceName: "GreenTile"))))
        case .J:
            addChild(createSingleBlock(color: UIColor.blue, position: CGPoint(x: -gridSize * 1.5, y: gridSize / 2.0), texture: SKTexture(image: #imageLiteral(resourceName: "BlueTile"))))
            addChild(createSingleBlock(color: UIColor.blue, position: CGPoint(x: -gridSize * 0.5, y: gridSize / 2.0), texture: SKTexture(image: #imageLiteral(resourceName: "BlueTile"))))
            addChild(createSingleBlock(color: UIColor.blue, position: CGPoint(x: gridSize * 0.5, y: gridSize / 2.0), texture: SKTexture(image: #imageLiteral(resourceName: "BlueTile"))))
            addChild(createSingleBlock(color: UIColor.blue, position: CGPoint(x: gridSize * 0.5, y: -gridSize / 2.0), texture: SKTexture(image: #imageLiteral(resourceName: "BlueTile"))))
        case .L:
            addChild(createSingleBlock(color: UIColor.red, position: CGPoint(x: -gridSize / 2.0, y: gridSize / 2.0), texture: SKTexture(image: #imageLiteral(resourceName: "CyanTile"))))
            addChild(createSingleBlock(color: UIColor.red, position: CGPoint(x: -gridSize / 2.0, y: -gridSize / 2.0), texture: SKTexture(image: #imageLiteral(resourceName: "CyanTile"))))
            addChild(createSingleBlock(color: UIColor.red, position: CGPoint(x: gridSize / 2.0, y: gridSize / 2.0), texture: SKTexture(image: #imageLiteral(resourceName: "CyanTile"))))
            addChild(createSingleBlock(color: UIColor.red, position: CGPoint(x: gridSize * 1.5, y: gridSize / 2.0), texture: SKTexture(image: #imageLiteral(resourceName: "CyanTile"))))
        case .S:
            addChild(createSingleBlock(color: UIColor.orange, position: CGPoint(x: -gridSize / 2.0, y: -gridSize / 2.0), texture: SKTexture(image: #imageLiteral(resourceName: "PinkTile"))))
            addChild(createSingleBlock(color: UIColor.orange, position: CGPoint(x: gridSize / 2.0, y: -gridSize / 2.0), texture: SKTexture(image: #imageLiteral(resourceName: "PinkTile"))))
            addChild(createSingleBlock(color: UIColor.orange, position: CGPoint(x: gridSize / 2.0, y: gridSize / 2.0), texture: SKTexture(image: #imageLiteral(resourceName: "PinkTile"))))
            addChild(createSingleBlock(color: UIColor.orange, position: CGPoint(x: gridSize * 1.5, y: gridSize / 2.0), texture: SKTexture(image: #imageLiteral(resourceName: "PinkTile"))))
        case .Z:
            addChild(createSingleBlock(color: UIColor.purple, position: CGPoint(x: -gridSize * 1.5, y: gridSize / 2.0), texture: SKTexture(image: #imageLiteral(resourceName: "PurpleTile"))))
            addChild(createSingleBlock(color: UIColor.purple, position: CGPoint(x: -gridSize / 2.0, y: gridSize / 2.0), texture: SKTexture(image: #imageLiteral(resourceName: "PurpleTile"))))
            addChild(createSingleBlock(color: UIColor.purple, position: CGPoint(x: -gridSize / 2.0, y: -gridSize / 2.0), texture: SKTexture(image: #imageLiteral(resourceName: "PurpleTile"))))
            addChild(createSingleBlock(color: UIColor.purple, position: CGPoint(x: gridSize / 2.0, y: -gridSize / 2.0), texture: SKTexture(image: #imageLiteral(resourceName: "PurpleTile"))))
        case .T:
            addChild(createSingleBlock(color: UIColor.magenta, position: CGPoint(x: -gridSize * 1.5, y: gridSize / 2.0), texture: SKTexture(image: #imageLiteral(resourceName: "OrangeTile"))))
            addChild(createSingleBlock(color: UIColor.magenta, position: CGPoint(x: -gridSize / 2.0, y: gridSize / 2.0), texture: SKTexture(image: #imageLiteral(resourceName: "OrangeTile"))))
            addChild(createSingleBlock(color: UIColor.magenta, position: CGPoint(x: -gridSize / 2.0, y: -gridSize / 2.0), texture: SKTexture(image: #imageLiteral(resourceName: "OrangeTile"))))
            addChild(createSingleBlock(color: UIColor.magenta, position: CGPoint(x: gridSize / 2.0, y: gridSize / 2.0), texture: SKTexture(image: #imageLiteral(resourceName: "OrangeTile"))))
        }
    }
    
    
}
