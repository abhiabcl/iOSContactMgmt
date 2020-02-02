//
//  ProviderDelegate.swift
//  HelloXCode
//
//  Created by Abhishek on 2/1/20.
//  Copyright © 2020 Abhishek. All rights reserved.
//

import Foundation

import CallKit

class ProviderDelegate: NSObject {
  // 1.
  private let callManager: CXCallDirectoryManager
  private let provider: CXCallDirectoryProvider
  
  init(callManager: CXCallDirectoryManager) {
    self.callManager = callManager
    // 2.
    provider = CXCallDirectoryProvider(configuration: ProviderDelegate.providerConfiguration)
    
    super.init()
    // 3.
    provider.setDelegate(self as! CXProviderDelegate, queue: nil)
  }
  
  // 4.
  static var providerConfiguration: CXProviderConfiguration = {
    let providerConfiguration = CXProviderConfiguration(localizedName: "Hotline")
    
    providerConfiguration.supportsVideo = true
    providerConfiguration.maximumCallsPerCallGroup = 1
    providerConfiguration.supportedHandleTypes = [.phoneNumber]
    
    return providerConfiguration
  }()
}
