//
//  Keyboard.swift
//  
//
//  Created by David Green on 10/22/20.
//

import Foundation


/// Allows getting keystrokes from the keyboard.
public class Keyboard {

    /// Returns the current keyboard state.
    /// - Returns: Current keyboard state.
    public static func getState() -> KeyboardState {
//        return PlatformGetState() // TODO: Implement this for real
        return KeyboardState()
    }
}
