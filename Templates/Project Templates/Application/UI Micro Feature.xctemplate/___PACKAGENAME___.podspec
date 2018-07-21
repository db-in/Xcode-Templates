Pod::Spec.new do |s|
  s.name = "___PACKAGENAME___"
  s.version = "1.0.0"
  s.summary = "UI Micro Feature"
  s.description = <<-DESC
                  ___PACKAGENAME___ is resposible for ...
                  DESC
  s.homepage = "http://___ORGANIZATIONNAME___"
  s.documentation_url = "https://___ORGANIZATIONNAME___.github.io/___PACKAGENAME___/"
  s.license = { :type => "MIT", :file => "LICENSE" }
  s.author = '___ORGANIZATIONNAME___'
  s.source = { :git => "___VARIABLE_gitURL___", :tag => s.version, :submodules => true }
  s.swift_version = '4.1'

  s.requires_arc = true
  s.ios.deployment_target = '10.0'

  s.public_header_files = '___PACKAGENAME___/**/*.h'
  s.source_files = '___PACKAGENAME___/**/*.{h,m,swift}'
  s.exclude_files = '___PACKAGENAME___/**/Info.plist'
  s.resource = ['___PACKAGENAME___/**/*.{xcassets,storyboard,xib,json}']

  s.ios.frameworks = 'UIKit'

end
