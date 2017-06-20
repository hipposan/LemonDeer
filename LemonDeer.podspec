Pod::Spec.new do |s|
  s.name             = 'LemonDeer'
  s.version          = '1.0.1'
  s.summary          = 'Make m3u8 parse and download as a breeze.'

  s.description      = <<-DESC
LemonDeer is an iOS framewrok that parses m3u8 file and downloads videos easy as breeze. It is written purely in Swift, along with several useful customizable methods.
                       DESC

  s.homepage         = 'https://github.com/hipposan/LemonDeer'
  s.screenshots     = 'https://raw.githubusercontent.com/hipposan/LemonDeer/master/Resources/LemonDeer-logo.png'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'hippo_san' => 'zzy0600@gmail.com' }
  s.source           = { :git => 'https://github.com/hipposan/LemonDeer.git', :tag => s.version.to_s }
  s.social_media_url = 'https://github.com/hipposan'

  s.ios.deployment_target = '9.0'

  s.source_files = 'LemonDeer/Classes/**/*'
end
