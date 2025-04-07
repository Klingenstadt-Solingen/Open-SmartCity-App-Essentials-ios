//
//  Publisher+Mapping.swift
//  OSCAEssentials
//
//  Created by Stephan Breidenbach on 23.02.22.
//

import Foundation
import Combine
public extension Publisher {
    /// `Publisher`-protocol's custom method
    ///
    /// [based upon](https://www.swiftbysundell.com/articles/calling-async-functions-within-a-combine-pipeline/)
    func asyncMap<T> (
        _ transform: @escaping (Output) async -> T
    ) -> Publishers.FlatMap<Future<T, Never>, Self> {
        flatMap { value in
            Future { promise in
                Task {
                    let output = await transform(value)
                    promise(.success(output))
                }// end Task
            }// end Future
        }// end flatMap
    }// end func asyncMap
    
    /// generic asynchron mapping with `Element` conforming `Codable` protocol and `Exception`conforming `Error`protocol
    func asyncMap<Element:Codable, Exception> (_ transform: @escaping (Output) async -> Element) -> Publishers.FlatMap<Future<Element, Exception>, Self >  {
        flatMap { value in
            Future { promise in
                Task {
                    let output = await transform(value)
                    promise(.success(output))
                }// end Task
            }// end Future
        }// end flatMap
    }// end func asyncMap
    
    /// `Publisher`-protocol's custom `throwing` method
    ///
    /// [based upon](https://www.swiftbysundell.com/articles/calling-async-functions-within-a-combine-pipeline/)
    func asyncMap<T> (
        _ transform: @escaping (Output) async throws -> T
    ) -> Publishers.FlatMap<Future<T, Error>, Self> {
        flatMap { value in
            Future { promise in
                Task {
                    do {
                        let output = try await transform(value)
                        promise(.success(output))
                    } catch {
                        promise(.failure(error))
                    }// end do catch
                }// end Task
            }// end Future
        }// end flatMap
    }// end func asyncMap throwing
}// end extension Protocol Publisher
