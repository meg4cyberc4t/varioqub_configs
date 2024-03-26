//
//  VarioqubNullAdapter.swift
//  varioqub_configs
//
//  Created by Igor Molchanov on 27.02.2024.
//
import Varioqub
import Foundation


public class VarioqubNullHandler: NSObject, VarioqubIdProvider, VarioqubReporter {
    private var deviceId: String = "000"
    private var userId: String = "000"
    
    public func fetchIdentifiers(completion: @escaping Completion) {
        completion(Result.success(VarioqubIdentifiers(deviceId: deviceId, userId: userId)))
    }
    
    public var varioqubName: String = "VarioqubNullHandler"
    
    public func setExperiments(_ experiments: String) { }
    
    public func setTriggeredTestIds(_ triggeredTestIds: Varioqub.VarioqubTestIDSet) { }
    
    public func sendActivateEvent(_ eventData: Varioqub.VarioqubEventData) {}
}
