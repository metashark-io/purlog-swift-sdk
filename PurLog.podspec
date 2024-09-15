Pod::Spec.new do |spec|
  spec.name         = "PurLog"
  spec.version      = "0.1.0"
  spec.summary      = "A logging SDK for Swift."
  spec.description  = "A logging SDK for Swift (iOS, iPadOS, macOS, watchOS, tvOS, visionOS)."
  spec.homepage     = "https://github.com/metashark-io/purlog-swift-sdk"
  spec.license      = { :type => "MIT", :file => "LICENSE" }
  spec.author       = { "MetaShark" => "grant@metashark.io" }
  spec.source       = { :git => "https://github.com/metashark-io/purlog-swift-sdk", :tag => "#{spec.version}" }

  spec.ios.deployment_target = "14.0"

  spec.source_files = "PurLog/**/*.{swift,h,m}"
  spec.requires_arc = true
end