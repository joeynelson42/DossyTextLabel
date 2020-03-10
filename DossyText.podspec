Pod::Spec.new do |s|
  s.name             = 'DossyText'
  s.version          = '1.0.0'
  s.summary          = 'A subclass of UILabel reminiscent of Strong Bads Tandy 400'

  s.description      = <<-DESC
A subclass of UILabel that allows for auto-typing and blinking, similar to MS-DOS.
DESC

  s.homepage         = 'https://github.com/joeynelson42/DossyTextLabel'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'Joey Nelson' => 'joeynelson42@gmail.com' }
  s.source           = { :git => 'https://github.com/joeynelson42/DossyTextLabel.git', :tag => s.version.to_s }

  s.ios.deployment_target = '10.0'
  s.source_files = 'DossyTextLabel/Source/DossyTextLabel.swift'

end
