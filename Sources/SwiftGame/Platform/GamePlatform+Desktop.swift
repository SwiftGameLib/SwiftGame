//
//  GamePlatform+Desktop.swift
//  
//
//  Created by David Green on 10/22/20.
//

import Foundation

// Vends platform specific instances
extension GamePlatform {
    internal static func platformCreate(withGame game: Game) -> GamePlatform {
//        #if os(macOS) // Any SDL based platform // TODO: Setup multiplatform support
        return SDLGamePlatform(withGame: game)
//        #endif
    }
}
