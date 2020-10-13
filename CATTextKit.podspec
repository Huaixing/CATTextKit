Pod::Spec.new do |s|
  s.name             = 'CATTextKit'
  s.version          = '0.1.8'
  s.summary          = 'text view and text label'
  s.description      = <<-DESC
Emoji text view and text label
                       DESC
  s.homepage         = 'https://github.com/Huaixing/CATTextKit'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'Huaixing' => 'shxwork@163.com' }
  s.source           = { :git => 'https://github.com/Huaixing/CATTextKit.git', :tag => s.version.to_s }
  s.ios.deployment_target = '11.0'
  s.source_files = 'CATTextKit/Classes/**/*'
  s.resources = ['CATTextKit/Emoji/*.xml','CATTextKit/Emoji/*.bundle',]
  s.resource_bundles = {
    'CATTextKit' => ['CATTextKit/Assets/*.png']
  }
  s.dependency 'CATCommonKit', '~> 0.2.0'
end
