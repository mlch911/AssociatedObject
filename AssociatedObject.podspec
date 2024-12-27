Pod::Spec.new do |s|

  s.name         = "AssociatedObject"
  s.version      = "0.10.2"
  s.summary      = "Swift Macro for allowing variable declarations even in class extensions."

  s.description  = <<-DESC
  Swift Macro for allowing variable declarations even in class extensions.
                   DESC

  s.homepage     = "https://github.com/p-x9/AssociatedObject"
  s.license      = { :type => "MIT", :file => "LICENSE" }
  s.author       = { "p-x9" => "https://github.com/p-x9" }

  s.ios.deployment_target = "13.0"
  s.tvos.deployment_target = "13.0"
  s.osx.deployment_target = "10.15"
  s.watchos.deployment_target = "6.0"

  s.source       = { :git => "https://github.com/p-x9/AssociatedObject.git", :tag => "#{s.version}" }

  s.prepare_command = <<-CMD
    set -e
    swift build -c release
    if [ $? -ne 0 ]; then
      echo "Error: Failed to build AssociatedObject"
      exit 1
    fi

    if [ -f ".build/release/AssociatedObjectPlugin-tool" ]; then
      cp -f .build/release/AssociatedObjectPlugin-tool ./Binary/AssociatedObjectPlugin
    elif [ -f ".build/release/AssociatedObjectPlugin" ]; then
      cp -f .build/release/AssociatedObjectPlugin ./Binary/AssociatedObjectPlugin
    else
      echo "Error: Neither AssociatedObjectPlugin-tool nor AssociatedObjectPlugin found in .build/release"
      exit 1
    fi

    if [ $? -ne 0 ]; then
      echo "Error: Failed to copy AssociatedObjectPlugin to Binary directory"
      exit 1
    fi
  CMD

  s.source_files  = "Sources/AssociatedObject/**/*.{c,h,m,swift}", 'Sources/AssociatedObjectC/**/*.{c,h,m,swift}'
  s.swift_versions = "5.9"

  # CocoaPods do not support Linux
  # s.dependency "ObjectAssociation", "0.5.0"

  s.preserve_paths = ["Binary/AssociatedObjectPlugin"]
  s.pod_target_xcconfig = {
    'OTHER_SWIFT_FLAGS' => [
      '-load-plugin-executable ${PODS_ROOT}/AssociatedObject/Binary/AssociatedObjectPlugin#AssociatedObjectPlugin'
    ]
  }
  s.user_target_xcconfig = {
    'OTHER_SWIFT_FLAGS' => [
      '-load-plugin-executable ${PODS_ROOT}/AssociatedObject/Binary/AssociatedObjectPlugin#AssociatedObjectPlugin'
    ]
  }

end
