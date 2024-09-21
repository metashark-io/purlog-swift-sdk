# PurLog

<p align="center">
A remote logging SDK for Swift (iOS, iPadOS, macOS, watchOS, tvOS, visionOS).
</p>

<p align="center">
  <a href="#">
    <img src="https://img.shields.io/badge/version-0.1.0-blue" alt="Version">
  </a>
      <img src="https://dl.circleci.com/status-badge/img/circleci/QHEuwkxDTekYMK98ity4TZ/TWGJsGj8BZfk7zWxRHHivb/tree/main.svg?style=shield&circle-token=CCIPRJ_9jUzr3iF6zTXTuNYt8iphq_d4244d11b2f06e07038419520974d436f6ef3ba2" alt="CircleCI">
  <a href="https://codecov.io/gh/metashark-io/purlog-ios">
    <img src="https://codecov.io/gh/metashark-io/purlog-ios/graph/badge.svg?token=H66O7DR38E" alt="Codecov">
  </a>
</p>


<p align="center">
<img width="500" alt="Screenshot 2024-09-21 at 6 20 45 AM" src="https://github.com/user-attachments/assets/dd0728a4-7331-4bcd-860f-434250b2ce3c">
</p>



## Installation

### CocoaPods

```ruby
pod 'PurLog', '~> 0.1.0'
```


### Swift Package Manager

In Xcode, go to File > Add Packages.

```
https://github.com/metashark-io/purlog-swift-sdk.git
```

## Usage


```swift
import PurLog
```


### Initialization


```swift
let config = PurLogConfig.Builder()
            .setLevel(.DEBUG) // (optional) defaults to .VERBOSE 
            .setEnv(.PROD) // (optional) defaults to .DEV
            .setProject(projectId: projectId, projectJWT: jwt) // (optional) configures remote logging so you can view logs on the PurLog web app
            .build()

Task {
    let initializationResult = await PurLog.shared.initialize(config: config)
}
```

Note: to use `.setProject()`, you must configure a [PurLog](https://app.purlog.io) project 


### Logging


After a successfull initialization, you'll be able to invoke logs

```swift
PurLog.shared.log("Test DEBUG Log", level: .DEBUG)
```

You can also include `metadata` if needed:

```swift
PurLog.shared.log("Test DEBUG Log", metadata: ["key": "value"] level: .DEBUG)
```


### Example


```swift
import PurLog
import SwiftUI

@main
struct PurLogSampleApp: App {
    
    init() {
        let projectId = "YOUR_PURLOG_PROJECT_ID"
        let jwt = Secrets.projectJWT // The project JWT shouldn't be hardcoded in your project. It should typically be securely passed down from your server environment
        
        let config = PurLogConfig.Builder()
            .setProject(projectId: projectId, projectJWT: jwt)
            .build()
        
        Task {
            _ = await PurLog.shared.initialize(config: config)
            PurLog.shared.log("Test VERBOSE Log", metadata: ["key": "value"], level: .VERBOSE)
            PurLog.shared.log("Test DEBUG Log", level: .DEBUG)
            PurLog.shared.log("Test INFO Log", level: .INFO)
            PurLog.shared.log("Test WARN Log", level: .WARN)
            PurLog.shared.log("Test ERROR Log", level: .ERROR)
            PurLog.shared.log("Test FATAL Log", level: .FATAL)
        }
    }
    
    var body: some Scene {
        WindowGroup {}
    }
}
```
