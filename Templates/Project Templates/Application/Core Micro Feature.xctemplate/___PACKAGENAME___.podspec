Pod::Spec.new do |s|
  s.name = "___PACKAGENAME___"
  s.version = "1.0.0"
  s.summary = "Micro Feature"
  s.description = <<-DESC
                  ___PACKAGENAME___ is resposible for ...
                  DESC
  s.homepage = "http://___ORGANIZATIONNAME___"
  s.documentation_url = "https://___ORGANIZATIONNAME___.github.io/___PACKAGENAME___/"
  s.license = { :type => "MIT", :file => "LICENSE" }
  s.author = '___ORGANIZATIONNAME___'
  s.source = { :git => "___VARIABLE_gitURL___", :tag => s.version, :submodules => true }
  s.swift_version = '5.0'

  s.requires_arc = true
  s.ios.deployment_target = '11.1'
  s.osx.deployment_target = '10.10'
  s.tvos.deployment_target = '9.0'
  s.watchos.deployment_target = '2.0'

  s.public_header_files = '___PACKAGENAME___/**/*.h'
  s.source_files = '___PACKAGENAME___/**/*.{h,m,swift}'
  s.exclude_files = '___PACKAGENAME___/**/Info.plist'

  s.ios.frameworks = 'Foundation'

end
