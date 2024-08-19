Pod::Spec.new do |spec|
  spec.name         = "PurLog"
  spec.version      = "0.1.0"
  spec.summary      = "A short description of PurLog."
  spec.description  = <<-DESC
  A longer description of PurLog.
  DESC
  spec.homepage     = "https://github.com/metashark-io/purlog-ios"
  spec.license      = { :type => "MIT", :file => "LICENSE" }
  spec.author       = { "MetaShark" => "grant@metashark.io" }
  spec.source       = { :git => "https://github.com/metashark-io/purlog-ios", :tag => "#{spec.version}" }

  spec.ios.deployment_target = "13.0"

  spec.source_files = "PurLog/**/*.{swift,h,m}" # Update this path to match your project
  spec.requires_arc = true