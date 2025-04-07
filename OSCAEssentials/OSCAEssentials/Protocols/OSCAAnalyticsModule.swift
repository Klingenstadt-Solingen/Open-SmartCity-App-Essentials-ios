//
//  OSCAAnalyticsModule.swift
//  
//
//  Created by Mammut Nithammer on 18.08.22.
//

import Foundation

public protocol OSCAAnalyticsModule {
    var externalUserId: String? { get set }
    var isOptOut: Bool { get set }
    
    func track(_ type: OSCAAnalyticsEvent, name: String?, parameters: [String:Any])
    func startSession()
    func endSession()
}
