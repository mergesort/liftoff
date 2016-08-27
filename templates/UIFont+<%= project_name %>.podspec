Pod::Spec.new do |spec|
  spec.name         = 'UIFont+<%= project_name %>'
  spec.summary      = 'The app\'s fonts'
  spec.version      = '1.0'
  spec.license      = { :type => 'MIT' }
  spec.authors      =  { '' => '' }
  spec.source_files = '*.swift'
  spec.ios.deployment_target = '9.0'
  spec.requires_arc = true
  spec.framework    = 'Foundation'
  spec.homepage = 'www.snarkbots.com'
  spec.source  = { :git => '' }
end