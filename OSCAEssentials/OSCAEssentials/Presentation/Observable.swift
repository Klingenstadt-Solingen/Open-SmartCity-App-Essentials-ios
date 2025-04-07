//
//  Observable.swift
//  OSCAEssentials
//
//  Created by Stephan Breidenbach on 26.04.21.
//
import UIKit


public final class Observable<Value> {
    
    public typealias ObservableHandler = ((Value) -> Void)
    
    struct Observer<Value> {
        weak var observer: AnyObject?
        let block: ObservableHandler
    }// end struct Observer
    
    private var observerList: [Observer<Value>] = []
    
    public var value: Value {
        didSet { self.notifyObservers(self.observerList) }
    }// end value
    
    public init(_ value: Value) {
        self.value = value
    }// end init
    
    public func observe(on observer: AnyObject,
                        observerBlock: @escaping ObservableHandler) {
        self.observerList.append(Observer(observer: observer,
                                          block: observerBlock))
        observerBlock(self.value)
    }// end func observe
    
    internal func remove(observer: AnyObject) {
        self.observerList = self.observerList.filter { $0.observer !== observer }
    }// end func remove
    
    public func removeAll(){
        self.observerList.removeAll()
    }// end public func removeAll
    
    private func notifyObservers(_ observerList: [Observer<Value>]) {
        for observer in observerList {
            DispatchQueue.main.async { observer.block(self.value) }
        }// end for observer in observerList
    }// end public func notifyObservers
    
    deinit {
        self.removeAll()
        #if DEBUG
            print("deInit: \(self.observerList)")
        #endif
    }// end deinit
}// end final class Observable
