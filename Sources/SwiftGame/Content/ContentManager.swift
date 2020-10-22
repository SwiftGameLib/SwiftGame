//
//  ContentManager.swift
//  
//
//  Created by David Green on 10/22/20.
//

import Foundation

// TODO: Implement this for real

public class ContentManager {

    private var _rootDirectory: String = ""

    public var rootDirectory: String {
        get {
            return _rootDirectory
        }
        set {
            _rootDirectory = newValue
        }
    }
}
