//
//  SpriteBatch.swift
//  
//
//  Created by David Green on 10/22/20.
//

// TODO: Implement this
public class SpriteBatch: GraphicsResourceProtocol {
    public var graphicsDevice: GraphicsDevice
    
    public init(withGraphicsDevice graphicsDevice: GraphicsDevice, capacity: Int = 0) {
        self.graphicsDevice = graphicsDevice
    }
}
