Pod::Spec.new do |spec|
  spec.name         = "PurLog"
  spec.version      = "0.1.1"
  spec.summary      = "A remote logging SDK for Swift."
  spec.description  = "A remote logging SDK for Swift (iOS, iPadOS, macOS, watchOS, tvOS, visionOS)."
  spec.homepage     = "https://github.com/metashark-io/purlog-swift-sdk"
  spec.license      = { :type => "MIT", :file => "LICENSE" }
  spec.author       = { "MetaShark" => "grant@metashark.io" }
  spec.source       = { :git => "https://github.com/metashark-io/purlog-swift-sdk.git", :tag => "#{spec.version}" }

  # Deployment targets for each platform
  spec.ios.deployment_target = "14.0"
  spec.osx.deployment_target = "12.0"
  spec.watchos.deployment_target = "8.5"
  spec.tvos.deployment_target = "15.5"
  spec.visionos.deployment_target = "1.2"

  spec.source_files = "PurLog/**/*.{swift,h,m}"
  spec.requires_arc = true
  spec.swift_version = '5.0'
end