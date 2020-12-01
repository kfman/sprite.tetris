//
//  SiezHelper.swift
//  tetris
//
//  Created by Klaus Fischer on 01.12.20.
//

import CoreGraphics

enum SizeRef{
    case width, height
}

class SizeHelper{
    
    static func scale(from parent: CGSize, edge reference: SizeRef, scale factor: CGFloat) -> CGSize {
        return CGSize(width: parent.width * factor, height: parent.height * factor)
    }
    
}
