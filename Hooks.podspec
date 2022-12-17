Pod::Spec.new do |s|
  s.name             = 'Hooks'
  s.version          = '0.0.4'
  s.summary          = 'Hooks for SwiftUI, It\'s react hooks counterpart'

  s.description      = <<-DESC
  A SwiftUI implementation of React Hooks. Enhances reusability of stateful logic and gives state and lifecycle to function view.
                       DESC

  s.homepage         = 'https://github.com/hollyoops/SwiftUI-Hooks'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'hcli@thoughtworks.com' => 'hcli@thoughtworks.com' }
  s.source           = { :git => 'https://github.com/hollyoops/SwiftUI-Hooks.git', :tag => s.version.to_s }

  s.platform = :ios, '13.0'

  s.source_files = 'Sources/**/*.swift'
  s.swift_version = '5'
  
  s.test_spec 'HooksTests' do |test_spec|
    test_spec.source_files = 'Tests/**/*Tests.Swift'
  end
end
