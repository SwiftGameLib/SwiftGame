//
//  Game.swift
//  
//
//  Created by David Green on 10/22/20.
//

// TODO: Implement
open class Game {

    private var _content: ContentManager? = nil

    public required init() {
        // TODO: needs a real implementation
        _content = ContentManager()
    }

    public var content: ContentManager {
        get {
            return _content!
        }
        set {
            _content = newValue
        }
    }

    public var graphicsDevice: GraphicsDevice {
        // TODO: Implement this correctly
        return GraphicsDevice()
    }

    public func exit() {
        
    }
    
    public func run() {
        
    }
    
    open func initialize() {
        
    }
    
    open func loadContent() {}
    
    open func unloadContent() {}
    
    open func draw(gameTime: GameTime) {}
    
    open func update(gametime: GameTime) {}
}
