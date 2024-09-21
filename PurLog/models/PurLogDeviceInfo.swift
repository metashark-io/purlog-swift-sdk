//
//  PurLogDeviceInfo.swift
//  PurLog
//
//  Created by Grant Espanet on 9/21/24.
//

import Foundation
#if os(iOS) || os(tvOS)
import UIKit
#endif


internal struct PurLogDeviceInfo {
    let osName: String
    let osVersion: String
    //let deviceModel: String // TODO:
    let appVersion: String
    
    init() {
        let osName: String
        let processInfo = ProcessInfo.processInfo
        
        // Determine the OS platform
        #if os(iOS)
            osName = UIDevice.current.userInterfaceIdiom == .pad ? "iPadOS" : "iOS"
        #elseif os(macOS)
            osName = "macOS"
        #elseif os(tvOS)
            osName = "tvOS"
        #elseif os(watchOS)
            osName = "watchOS"
        #elseif os(visionOS)
            osName = "visionOS"
        #else
            osName = "Unknown OS"
        #endif

        // Get the OS version
        let osVersion = processInfo.operatingSystemVersion
        let versionString = "\(osVersion.majorVersion).\(osVersion.minorVersion).\(osVersion.patchVersion)"
            
        self.osName = osName
        self.osVersion = versionString
        self.appVersion = Bundle.main.infoDictionary?["CFBundleShortVersionString"] as? String ?? "Unknown"
    }
    
    func asDictionary() -> [String: String] {
        return [
            "osName": osName,
            "osVersion": osVersion,
            //"deviceModel": deviceModel,
            "appVersion": appVersion
        ]
    }
}
