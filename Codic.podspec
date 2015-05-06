Pod::Spec.new do |s|
  s.name = 'Codic'
  s.version = '0.0.1'
  s.license = 'MIT'
  s.summary = 'A codic API v1 client for Swift.'
  s.homepage = 'https://github.com/to4iki/Codic'
  s.social_media_url = 'http://twitter.com/to4iki'
  s.authors = { 'tsk takezawa' => 'tsk.take815@gmail.com' }
  s.source = { :git => 'https://github.com/to4iki/Codic.git', :tag => "#{s.version}" }

  s.ios.deployment_target = '8.0'
  s.osx.deployment_target = '10.10'

  s.source_files = 'Codic/**/*.swift'

  s.requires_arc = true
end
