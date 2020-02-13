Pod::Spec.new do |spec|
  spec.name = "HandlersKit"
  spec.version = "1.0.0"
  spec.summary = "Swift closure-based actions and delegates to UIKit"

  spec.homepage = "https://github.com/hhru/HandlersKit"
  spec.license = { :type => 'MIT', :file => 'LICENSE' }
  spec.author = { "HeadHunter iOS Team" => "https://hh.ru" }
  spec.source = { :git => "https://github.com/hhru/HandlersKit.git", :tag => "#{spec.version}" }

  spec.swift_version = '5.0'
  spec.requires_arc = true
  spec.source_files = 'Sources/**/*.swift'

  spec.ios.frameworks = 'UIKit'
  spec.ios.deployment_target = "10.0"
end
