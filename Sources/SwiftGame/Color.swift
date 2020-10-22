//
//  Color.swift
//  
//
//  Created by David Green on 10/22/20.
//

import Foundation

// TODO: Implement the res of this
public struct Color: Equatable {
    // MARK: Static color values
    
    public static let cornflowerBlue = Color(0xffed9564)
    
    
    // MARK: Internal iVars
    
    /// Stored as RGBA with R in the least significant byte
    /// `|-------|-------|-------|-------`
    /// `A       B       G       R`
    var _packedValue: UInt32
    
    // MARK: Initializers
    
    /// Constructs an RGBA color from a packed value.
    /// The value is a 32-bitt unsigned integer with R in the least significant byte.
    /// - Parameter packedValue: The packed value
    init(_ packedValue: UInt32) {
        _packedValue = packedValue
    }
}
