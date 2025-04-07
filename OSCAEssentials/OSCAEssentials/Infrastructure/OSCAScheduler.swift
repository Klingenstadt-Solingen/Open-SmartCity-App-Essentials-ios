//
//  OSCAScheduler.swift
//
//
//  Created by Mammut Nithammer on 09.01.22.
//

import Combine
import Foundation

public final class OSCAScheduler {
  public static var backgroundWorkScheduler: OperationQueue = {
    let operationQueue = OperationQueue()
    operationQueue.maxConcurrentOperationCount = 5
    operationQueue.qualityOfService = QualityOfService.userInitiated
    return operationQueue
  }()
  
  public static let mainScheduler = RunLoop.main
}
