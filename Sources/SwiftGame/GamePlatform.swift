//
//  GamePlatform.swift
//  
//
//  Created by David Green on 10/22/20.
//

import Foundation

class GamePlatform {
    // MARK: iVars
    internal var _inactiveSleepTime: TimeSpan = TimeSpan.fromMilliseconds(milliseconds: 20.0)
    internal var _needsToResetElapsedTime: Bool = false
    internal var inFullScreenMode: Bool = false

    // MARK: Construction/Destruction
    internal init(withGame game: Game) {
        self.game = game
    }

    // MARK: Public Properties
    /// When implemented in a subclass, reports the default run behavior for this platform.
    public var defaultRunBehavior: GameRunBehavior {
        fatalError("defaultRunBehavior has not been implemented")
    }

    /// Gets the `Game` instance that owns this `GamePlatform` instance.
    private(set) public var game: Game

    private var _isActive: Bool = false
    public var isActive: Bool {
        get { return _isActive }
        set {
            _isActive = newValue
            NotificationCenter.default.post(name: _isActive ? Self.activatedNotification : Self.deactivatedNotification, object: self)
        }
    }

    private var _isMouseVisible: Bool = false
    public var isMouseVisible: Bool {
        get { return _isMouseVisible }
        set {
            if _isMouseVisible != newValue {
                _isMouseVisible = newValue
                // TODO: Implementation! self.onIsMouseVisibleChanged()
            }
        }
    }

    private var _window: GameWindow? = nil
    public var window: GameWindow {
        get { return _window! }
        set {
            if _window == nil {
                // TODO: Implementation! Mouse.primaryWindow = newValue
                // TODO: Implementation! TouchPanel.primaryWindow = newValue
            }
            _window = newValue
        }
    }

    // MARK: Events
    public static var asyncRunLoopEndedNotification: NSNotification.Name =
        NSNotification.Name(rawValue: "GamePlatform.AsyncRunLoopEndedNotification")
    public static var activatedNotification: NSNotification.Name =
        NSNotification.Name(rawValue:"GamePlatform.ActivatedNotification")
    public static var deactivatedNotification: NSNotification.Name =
        NSNotification.Name(rawValue:"GamePlatform.DeactivatedNotification")

    /// Posts the `asyncRunLoopEnded` notification. This method must be called by derived classes when the asynchronous run loop they start has stopped running.
    internal func postAsyncRunLoopEnded() {
        NotificationCenter.default.post(name: Self.asyncRunLoopEndedNotification, object: self)
    }

    // MARK: Methods

    /// Gives derived classes an opportunity to do work before any components are initialized.
    /// Note that the base implementation sets `isActive` to `true`, so derived classes should either call the super class or set `isActive` to true themselves.
    public func beforeInitialize() {
        isActive = true
    }

    /// Gives derived classes an opportunity to do work just before the run loop is begun.
    /// Implementations may also return `false` to prevent the run loop from starting.
    public func beforeRun() -> Bool {
        return true
    }

    /// When implemented in a derived class, ends the active run loop.
    public func exit() {}

    /// When implemented in a derived class, starts the run loop and blocks until it has ended.
    public func runLoop() {}

    /// When implemented in a derived class, starts the run loop and returns immediately.
    public func startRunLoop() {}

    /// Gives derived classes an opportunity to do work just before `update()` is called for all Updateable components.
    /// Returning `false` from this method will result in this round of `update()` calls being skipped.
    /// - Parameter gameTime:
    /// - Returns:
    public func beforeUpdate(gameTime: GameTime) -> Bool {
        return true
    }

    /// Gives derived classes an opportunity to do work just before `draw()` is called for all Drawable components.
    /// Returning `false` from this method will result in this round of `draw()` calls being skipped.
    /// - Parameter gameTime:
    /// - Returns:
    public func beforeDraw(gameTime: GameTime) -> Bool {
        return true
    }

    /// When implemented in a derived class, causes the game to enter full-screen mode.
    public func enterFullScreen() {}

    /// When implemented in a derived class, causes the game to exit full-screen mode.
    public func exitFullScreen() {}

    /// Gives derived classes an opportunity to modify `Game.targetElapsedTime` before it is set.
    /// - Parameter timeSpan: The proposed new value of `targetElapsedTime`.
    /// - Returns: The new value of `targetElapsedTime`.
    public func targetElapsedTimeChanging(timeSpan: TimeSpan) -> TimeSpan {
        return timeSpan
    }

    /// Starts a device transition (windowed to full screen or vice versa).
    /// - Parameter willBeFullScreen: whether the device will be in full-screen mode upon completion of the change.
    public func beginScreenDeviceChange(willBeFullScreen: Bool) {}

    /// Completes a device transition.
    /// - Parameters:
    ///   - screenDeviceName: The screen device name.
    ///   - clientWidth: The new width of the game clients window.
    ///   - clientHeight: The new height of the game's client window.
    public func endScreenDeviceChange(screenDeviceName: String, clientWidth: Int, clientHeight: Int) {}

    /// Gives derived classes an opportunity to take action after `Game.targetElapsedTime` has been set.
    public func targetElapsedTimeChanged() {}

    /// Use this method if your game is recovering from a slow-running state, and `elapsedGameTime` is too large to be useful.
    /// Frame timing is generally handled by the `Game` class, but some platforms still handle it elsewhere. Once all platforms rely
    /// on the `Game` class's functionality, this method and any overrides should be removed.
    public func resetElapsedTime() {}

    public func present() {}

    internal func onIsMouseVisibleChanged() {}

    /// Called by the `GraphicsDeviceManager`to notify the platform that the presentation parameters have changed.
    /// - Parameter parameters: The new presentation parameters.
    internal func onPresentationChanged(parameters: PresentationParameters) {}
}


