//
//  AsyncOperation.swift
//  APOD
//
//  Created by Ibm Mac on 4/08/20.
//  Copyright © 2020 harry. All rights reserved.
//

import Foundation

public enum State:String {
    case Ready, Executing, Finished
    
    fileprivate var  keyPath:String {
        return "is" + rawValue
    }
}


class AsyncOperation: Operation {
    public var state = State.Ready {
        willSet{
            willChangeValue(forKey: newValue.keyPath)
            willChangeValue(forKey: state.keyPath)
        }
        didSet{
            didChangeValue(forKey: oldValue.keyPath)
            didChangeValue(forKey: state.keyPath)
        }
    }
    
    
    open override var  isReady: Bool {
        super.isReady && state == .Ready
    }
    
    open override var isExecuting: Bool {
        state == .Executing
    }
    
    open override var isFinished: Bool {
        state == .Finished
    }
    
    open override var isAsynchronous: Bool {
        true
    }
    
    open override func start() {
        if isCancelled {
            state = .Finished
            return
        }
        main()
        state = .Executing
    }
    
    open override func cancel() {
        state = .Finished
    }
}
