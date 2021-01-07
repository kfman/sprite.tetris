//
//  Button.swift
//  tetrisNoBodies
//
//  Created by Klaus Fischer on 07.01.21.
//

import SpriteKit

class Button: SKSpriteNode{
    
    init(text: String, size: CGSize){
        super.init(texture: nil, color: UIColor.clear, size: size)
        
        let label = SKLabelNode(text: text)
        addChild(label)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
