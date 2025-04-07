//
//  BundleService.swift
//  OSCAEssentials
//
//  Created by Stephan Breidenbach on 10.06.21.
//
import Foundation

public enum BundleError: Error{
  case canceledError
  case wrongImagePathError
}// end enum BundleError

public protocol BundleCancelable {
  func cancel()
}// end protocol NetworkCancelable

public protocol BundleService {
  typealias CompletionHandler = (Result<String?, BundleError>) -> Void
  
  func request(imagePath: String?, completion: @escaping CompletionHandler) -> BundleCancelable?
}// end protocol BundleService

public protocol BundleErrorLogger {
  func log(error: Error)
}// end protocol BundleErrorLogger

class BundleTask: BundleCancelable {
  typealias CompletionHandler = (Result<String?, BundleError>) -> Void
  // MARK: - Property
  private var imagePath: String?
  private var resultTuple: Result<String?, BundleError>?
  private var completion: CompletionHandler
  /**
   - Parameters:
   - qos: quality of service
   */
  private lazy var taskWorkItem: DispatchWorkItem = {
    let ret = DispatchWorkItem(qos: .utility) {
      // the image path is not null!
      if let imagePathNN: String = self.imagePath {
        // async task to fetch something
        if !self.taskWorkItem.isCancelled {
          print("execute task!")
          usleep(1000)
          self.resultTuple = Result.success("Data touched, imagePath: \(imagePathNN)")
          usleep(1000)
        } else {
          self.resultTuple = Result.failure(BundleError.canceledError)
          print("task cancelled!")
        }// end if
      } else {
        self.resultTuple = Result.failure(BundleError.wrongImagePathError)
      }// end guard
    }// end ret
    return ret
  }()// end lazy var taskWorkItem
  
  private lazy var notifyWorkItem: DispatchWorkItem? = {
    let ret = DispatchWorkItem.init(qos: .userInteractive) {
      print("task completed!")
      guard let result: Result<String?, BundleError> = self.resultTuple else {
        return
      }
    }// end notifyWorkItem
    return ret
  }()// end lazy var notifyWorkItem
  
  private var isCancelled: Bool
  
  // MARK: - Constructor
  init(imagePath: String?,
       completion: @escaping CompletionHandler) {
    self.isCancelled = false
    self.imagePath = imagePath
    self.completion = completion
  }// end init
  
  // MARK: - Method
  func start() {
    // notify main queue, task work is done
    self.taskWorkItem.notify(queue: .main) {
      guard let notify: DispatchWorkItem = self.notifyWorkItem else { return }
      notify.perform()
    }// end notify
    // execute task
    DispatchQueue.global().async(execute: self.taskWorkItem)
  }// end func start
  
  func cancel() {
    self.taskWorkItem.cancel()
    self.isCancelled = true
  }// end func cancel
}// end struct BundleTask

// MARK: - Implementation

public final class DefaultBundleService {
  public typealias CompletionHandler = (Result<String?, BundleError>) -> Void
  
  private let logger: BundleErrorLogger
  
  public init(logger: BundleErrorLogger = DefaultBundleErrorLogger()) {
    self.logger = logger
  }// end init
  
  public func request(imagePath: String?, completion: @escaping CompletionHandler) -> BundleCancelable {
    let taskWorkItem = BundleTask(imagePath: imagePath,
                                              completion: completion)
    taskWorkItem.start()
    return taskWorkItem
  }// end func request
}// end final class DefaultNetworkService

// MARK: - Logger
public final class DefaultBundleErrorLogger: BundleErrorLogger {
  public init() { }
  
  public func log(error: Error) {
#if DEBUG
    print("-------------")
    print("\(error)")
#endif
  }// end func log
}// end final class DefaultDataTransferErrorLogger
