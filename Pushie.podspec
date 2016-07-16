Pod::Spec.new do |s|
  s.name             = 'Pushie'
  s.version          = '0.0.16'
  s.summary          = 'Pushie is a small framework for Writing Push Down Automata fast and easy'
  s.description      = "Pushie is a small framework for Writing Push Down Automata fast and easy. It allows you to parse words in the language you specify and even compute a full result from it usin generics."

  s.homepage         = 'https://github.com/mathiasquintero/Pushie'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'Mathias Quintero' => 'mathias.quintero@tum.de' }
  s.source           = { :git => 'https://github.com/mathiasquintero/Pushie.git', :tag => s.version.to_s }
  s.social_media_url = 'https://twitter.com/sifrinoimperial'

  s.ios.deployment_target = '8.0'

  s.source_files = 'Pushie/Classes/**/*'

end
