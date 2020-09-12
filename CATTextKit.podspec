#
# Be sure to run `pod lib lint CATTextKit.podspec' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see https://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
  s.name             = 'CATTextKit'
  s.version          = '0.1.5'
  s.summary          = 'text view and text label'

# This description is used to generate tags and improve search results.
#   * Think: What does it do? Why did you write it? What is the focus?
#   * Try to keep it short, snappy and to the point.
#   * Write the description between the DESC delimiters below.
#   * Finally, don't worry about the indent, CocoaPods strips it!

  s.description      = <<-DESC
Emoji text view and text label
                       DESC

  s.homepage         = 'https://github.com/Huaixing/CATTextKit'
  # s.screenshots     = 'www.example.com/screenshots_1', 'www.example.com/screenshots_2'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'Huaixing' => 'shxwork@163.com' }
  s.source           = { :git => 'https://github.com/Huaixing/CATTextKit.git', :tag => s.version.to_s }
  # s.social_media_url = 'https://twitter.com/<TWITTER_USERNAME>'

  s.ios.deployment_target = '10.0'

  s.source_files = 'CATTextKit/Classes/**/*'
  s.resources = ['CATTextKit/Emoji/*.xml','CATTextKit/Emoji/*.bundle',]
  s.resource_bundles = {
    'CATTextKit' => ['CATTextKit/Assets/*.png']
  }

  # s.public_header_files = 'Pod/Classes/**/*.h'
  # s.frameworks = 'UIKit', 'MapKit'
  # s.dependency 'AFNetworking', '~> 2.3'
end
