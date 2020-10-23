//
//  GameRunBehavior.swift
//  
//
//  Created by David Green on 10/22/20.
//

import Foundation

/// Defines how the `Game` should be run.
public enum GameRunBehavior {
    /// The game loop will be run asynchronous
    case asynchronous

    /// The game loop will be run synchronous
    case synchronous
}
