//
//  CustomCallDirectoryProvider.swift
//  HelloXCode
//
//  Created by Abhishek on 2/1/20.
//  Copyright © 2020 Abhishek. All rights reserved.
//

import Foundation
import CallKit


class CustomCallDirectoryProvider: CXCallDirectoryProvider {
    override func beginRequest(with context: CXCallDirectoryExtensionContext) {
        let labelsKeyedByPhoneNumber: [CXCallDirectoryPhoneNumber: String] = [ :]
        for (phoneNumber, label) in labelsKeyedByPhoneNumber.sorted(by: <) {
            context.addIdentificationEntry(withNextSequentialPhoneNumber: phoneNumber, label: label)
        }

        context.completeRequest()
    }
}
