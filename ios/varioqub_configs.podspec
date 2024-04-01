#
# To learn more about a Podspec see http://guides.cocoapods.org/syntax/podspec.html.
# Run `pod lib lint varioqub_configs.podspec` to validate before publishing.
#
Pod::Spec.new do |s|
  s.name             = 'varioqub_configs'
  s.version          = '0.7.1'
  s.summary          = 'Flutter plugin providing work with remote configs,experiments and A/B testing via Varioqub.'
  s.description      = <<-DESC
  Flutter plugin providing work with remote configs,
  experiments and A/B testing via Varioqub.
  Read the README for full details.
                       DESC
  s.homepage         = 'https://github.com/meg4cyberc4t/varioqub_configs'
  s.license          = { :file => '../LICENSE' }
  s.author           = { 'Igor Molchanov' => 'meg4cyberc4t@gmail.com' }
  s.source           = { :path => '.' }
  s.source_files = 'Classes/**/*'
  s.dependency 'Flutter'
  s.dependency 'Varioqub', '~> 0.6'
  s.dependency 'Varioqub/MetricaAdapter', '~> 0.6'


  s.platform = :ios, '12.0'
  s.static_framework = true

  # Flutter.framework does not contain a i386 slice.
  s.pod_target_xcconfig = { 'DEFINES_MODULE' => 'YES', 'EXCLUDED_ARCHS[sdk=iphonesimulator*]' => 'i386' }
  s.swift_version = '5.0'
end
