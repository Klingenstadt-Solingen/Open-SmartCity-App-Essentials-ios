//
//  OSCARepository.swift
//  OSCAEssentials
//
//  Created by Stephan Breidenbach on 23.02.22.
//

import Foundation
import Combine

public enum OSCARepository {
    public enum OSCACachingStrategy: String {
        case cacheThenNetwork = "First cache, then network."
        case networkThenCache = "First network, then cache."
        case networkOnly = "Network only,"
        case cacheOnly = "Cache only."
    }// end public enum OSCACachingStrategy
    
    
    /// fetch `Element`, which conforms to the `Codable`protocol from repository with `cachingStrategy`
    ///  - Parameter maxCount: maximum amount of `Element`s
    ///  - Parameter fetchFromCache: escaping closure which fetches the maximum amount of `Element`s from cache
    ///  - Parameter putToCache: escaping closure which put `Element`into cache
    ///  - Parameter fetchFromNetwork: publisher, which fetches the maximum amount of `Element`s from network
    public static func fetch<Element:Codable, Exception:Error>(maxCount: Int,
                                                               cachingStrategy: OSCARepository.OSCACachingStrategy = .networkThenCache,
                                                               fetchFromCache   : @escaping (Int) -> Element,
                                                               putToCache       : @escaping (Element) -> Element,
                                                               fetchfromNetwork : (Int) -> AnyPublisher<Element, Exception>) -> AnyPublisher<Element, Exception> {
        #if DEBUG
        print("\(String(describing: self)): \(#function)")
        #endif
        // initialize empty publisher
        var publisher: AnyPublisher<Element, Exception> = Empty(completeImmediately: true).eraseToAnyPublisher()
        // initialize fetch from Cache publisher
        let fetchFromCachePublisher: AnyPublisher<Element, Exception> = Just(fetchFromCache(maxCount))
            .setFailureType(to: Exception.self)
            .eraseToAnyPublisher()
        // evaluate caching strategy
        switch cachingStrategy {
            
        // there are two concatenated data publisher:
        // 1) fetch Element from cache
        // 2) fetch Element from network
        case .cacheThenNetwork:
            #if DEBUG
            print("\(String(describing: self)): \(#function) - case \(OSCACachingStrategy.cacheThenNetwork.rawValue)")
            #endif
            publisher = Publishers.Concatenate(
                // fetch elements from cache
                prefix: fetchFromCachePublisher,
                // fetch elements from network
                suffix: fetchfromNetwork(maxCount)
                    .catch({ return Fail.init(error: $0) })
                    // put from network fetched elements to cache
                    .asyncMap { return putToCache($0) }
                    // put fetched network elements into cache in background
                    .subscribe(on: OSCAScheduler.backgroundWorkScheduler)
                    .eraseToAnyPublisher()
            ).eraseToAnyPublisher()
           
        // fetch Element from network, when it fails then fetch Element from cache
        case .networkThenCache:
            #if DEBUG
            print("\(String(describing: self)): \(#function) - case \(OSCACachingStrategy.networkThenCache.rawValue)")
            #endif
            publisher = fetchfromNetwork(maxCount)
                // catch possible Exception s
                .catch({ _ in
                    // if network fetch fails, return Element from cache
                    return fetchFromCachePublisher
                })
                // receive fetched elements from network in background
                .receive(on: OSCAScheduler.backgroundWorkScheduler)
                // put fetched elements to cache
                .asyncMap { return putToCache($0) }// end asyncMap
                // put network elements into cache in background
                .subscribe(on: OSCAScheduler.backgroundWorkScheduler)
                .eraseToAnyPublisher()
            
        // fetch Element from network only
        case .networkOnly:
            #if DEBUG
            print("\(String(describing: self)): \(#function) - case \(OSCACachingStrategy.networkOnly.rawValue)")
            #endif
            publisher = fetchfromNetwork(maxCount)
                .catch({ return Fail.init(error: $0) })
                // receive fetched elements from network in background
                .receive(on: OSCAScheduler.backgroundWorkScheduler)
                // put from network fetched elements to cache
                .asyncMap { return putToCache($0) }
                // put fetched network elements into cache in background
                .subscribe(on: OSCAScheduler.backgroundWorkScheduler)
                .eraseToAnyPublisher()
            
        // fetch from cache only
        case .cacheOnly:
            #if DEBUG
            print("\(String(describing: self)): \(#function) - case \(OSCACachingStrategy.cacheOnly.rawValue)")
            #endif
            publisher = fetchFromCachePublisher
                // use background work scheduler for fetching elements from cache
                .subscribe(on: OSCAScheduler.backgroundWorkScheduler)
                // use background work scheduler for receiving from this publisher
                .receive(on: OSCAScheduler.backgroundWorkScheduler)
                .eraseToAnyPublisher()
        }// end switch case
        return publisher
    }// end public static func fetch generic with caching strategy
    
    
}// end public enum OSCARepository
