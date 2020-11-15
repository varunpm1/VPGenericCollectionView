Pod::Spec.new do |s|
  s.name             = 'VPGenericCollectionView'
  s.version          = '0.1.0'
  s.summary          = 'A class which handles homogeneous collection view cell population and auto resize cells, with very less code.'
  s.description      = 'Auto resizable homogeneous collection view cells with cell population handled completely using Generics. Cell handling is completely driven by generics with very easy setup of collection view and cell.'
  s.homepage         = 'https://github.com/varunpm1/VPGenericCollectionView'
  # s.screenshots     = 'www.example.com/screenshots_1', 'www.example.com/screenshots_2'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'varunpm1' => 'varun.pm1@gmail.com' }
  s.source           = { :git => 'https://github.com/varunpm1/VPGenericCollectionView.git', :tag => s.version.to_s }
  s.ios.deployment_target = '11.0'
  s.swift_versions = '5.3'

  s.source_files = 'VPGenericCollectionView/Classes/**/*'
  
  # s.resource_bundles = {
  #   'VPGenericCollectionView' => ['VPGenericCollectionView/Assets/*.png']
  # }

  # s.public_header_files = 'Pod/Classes/**/*.h'
end
