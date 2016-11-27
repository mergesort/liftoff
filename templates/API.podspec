Pod::Spec.new do |spec|
  spec.name         = 'API'
  spec.summary      = 'A generic API client'
  spec.version      = '1.0'
  spec.license      = { :type => 'MIT' }
  spec.authors      =  { 'Joe Fabisevich' => 'github@fabisevi.ch' }
  spec.source_files = '*.swift'
  spec.ios.deployment_target = '9.0'
  spec.requires_arc = true
  spec.framework    = 'Foundation'
  spec.homepage = 'https://github.com/mergesort/'
  spec.source  = { :git => 'https://github.com/mergesort' }
end
