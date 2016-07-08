#
# Be sure to run `pod lib lint Pushie.podspec' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see http://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
  s.name             = 'Pushie'
  s.version          = '0.1.0'
  s.summary          = 'Pushie is a small framework for Writing Push Down Automata fast and easy'

# This description is used to generate tags and improve search results.
#   * Think: What does it do? Why did you write it? What is the focus?
#   * Try to keep it short, snappy and to the point.
#   * Write the description between the DESC delimiters below.
#   * Finally, don't worry about the indent, CocoaPods strips it!

  s.description      = "Pushie is a small framework for Writing Push Down Automata fast and easy. It allows you to parse words in the language you specify and even compute a full result from it usin generics."

  s.homepage         = 'https://github.com/mathiasquintero/Pushie'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'Mathias Quintero' => 'mathias.quintero@tum.de' }
  s.source           = { :git => 'https://github.com/<GITHUB_USERNAME>/Pushie.git', :tag => s.version.to_s }
  s.social_media_url = 'https://twitter.com/sifrinoimperial'

  s.ios.deployment_target = '8.0'

  s.source_files = 'Pushie/Classes/**/*'
  
  # s.resource_bundles = {
  #   'Pushie' => ['Pushie/Assets/*.png']
  # }

  # s.public_header_files = 'Pod/Classes/**/*.h'
  # s.frameworks = 'UIKit', 'MapKit'
  # s.dependency 'AFNetworking', '~> 2.3'
end
