Pod::Spec.new do |s|
  s.name         = 'QuickPersist'
  s.version      = '1.0.1'
  s.summary      = 'Easily save Structs to Realm.'
  s.description  = <<-DESC
    QuickPersist lets you easily save any data type to a Realm database.
  DESC
  s.homepage     = 'https://github.com/cszatma/QuickPersist'
  s.license      = { :type => 'MIT', :file => 'LICENSE' }
  s.author       = { 'Christopher Szatmary' => 'cs@christopherszatmary.com' }
  s.source       = { :git => 'https://github.com/cszatma/QuickPersist.git', :tag => s.version.to_s }
  s.ios.deployment_target = '8.0'
  s.osx.deployment_target = '10.9'
  s.watchos.deployment_target = '2.0'
  s.tvos.deployment_target = '9.0'
  s.source_files  = 'Sources/**/*.{swift}'
  s.frameworks  = 'Foundation'
  s.dependency 'RealmSwift'
end
