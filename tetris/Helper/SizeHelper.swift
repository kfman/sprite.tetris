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
        
        let height = reference == SizeRef.height
        ? parent.height * factor
            : parent.width / parent.height * factor * parent.width
        
        return CGSize(width: parent.width * factor, height: height)
    }
    
}
