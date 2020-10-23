//
//  Game.swift
//  
//
//  Created by David Green on 10/22/20.
//

// TODO: Implement
open class Game {
    // MARK: iVars
    // private var _components: GameComponentCollection? = nil
    // private var _services: GameServicecontainer? = nil
    private var _content: ContentManager? = nil
    internal var platform: GamePlatform? = nil
    
//    private var _drawables: SortingFilteringCollection<DrawableProtocol> = ...
    
//    private var _updateables: SortingFilteringCollection<UpdateableProtocol> = ...
    
    private var _graphicsDeviceManager: GraphicsDeviceManagerProtocol? = nil
    private var _graphicsDeviceService: GraphicsDeviceServiceProtocol? = nil
    
    private var _initalized: Bool = false
    private var _isFixedTimeStep: Bool = true
    
    private var _targetElapsedTime: TimeSpan = TimeSpan(withTicks: 166667) // 60 fps

    // MARK: Construction/Destruction
    public required init() {
        Self._instance = self

        // TODO: launchParameters
        // TODO: _services
        // TODO: _components
        _content = ContentManager()

        platform = GamePlatform.platformCreate(withGame: self)
        // TODO: platform.activated += onActivated
        // TODO: platform.deactivated += onDeactivated
        // TODO: _services.addService(GamePlatform.self, platform)

        // Calling Update() for the first time initializes some systems
        // TODO: FrameworkDispatcher.update()

        // Allow some optional per-platform construction to occur.
        // TODO: PlatformConstruct()
    }

    // MARK: Properties

    private static var _instance: Game? = nil

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

    /// Run the game for one frame, then exit.
    public func runOneFrame() {

    }

    /// Run the game using the default `GameRunBehavior` for the current platform.
    public func run() {
        
    }

    /// Run the game
    /// - Parameter runBehavior: Indicate if the game should be run synchronously or asynchronously.
    public func run(withBehavior runBehavior: GameRunBehavior) {

    }
    
    open func initialize() {
        
    }
    
    open func loadContent() {}
    
    open func unloadContent() {}
    
    open func draw(gameTime: GameTime) {}
    
    open func update(gametime: GameTime) {}
}
