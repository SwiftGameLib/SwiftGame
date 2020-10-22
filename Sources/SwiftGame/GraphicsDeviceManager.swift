//
//  GraphicsDeviceManager.swift
//  
//
//  Created by David Green on 10/22/20.
//

// TODO: finish implementation
public class GraphicsDeviceManager: GraphicsDeviceServiceProtocol, GraphicsDeviceManagerProtocol {
    fileprivate let _game: Game
    
    public required init(withGame game: Game) {
        _game = game
    }
}
