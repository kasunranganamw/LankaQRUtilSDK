#
# Be sure to run `pod lib lint LankaQRUtilSDK.podspec' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see https://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
  s.name             = 'LankaQRUtilSDK'
  s.version          = '1.0.10'
  s.summary          = 'Lanka QR Validation.'

# This description is used to generate tags and improve search results.
#   * Think: What does it do? Why did you write it? What is the focus?
#   * Try to keep it short, snappy and to the point.
#   * Write the description between the DESC delimiters below.
#   * Finally, don't worry about the indent, CocoaPods strips it!

  s.description      = <<-DESC
LankaQRUtilSDK is an awesome pod that will fix Lanka QR scanning issue in iOS
                       DESC

  s.homepage         = 'https://github.com/kasunranganamw/LankaQRUtilSDK'
  # s.screenshots     = 'www.example.com/screenshots_1', 'www.example.com/screenshots_2'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'Kasun Rangana M W' => 'kasunranganamw@gmail.com' }
  s.source           = { :git => 'https://github.com/kasunranganamw/LankaQRUtilSDK.git', :tag => s.version.to_s }
  s.social_media_url = 'https://twitter.com/kasunranganamw'

  s.ios.deployment_target = '9.3'
  s.swift_version = '5.0'
  s.platforms = {
      "ios": "9.3"
  }

  s.source_files = 'Source/**/*.swift'
  
  # s.resource_bundles = {
  #   'LankaQRUtilSDK' => ['LankaQRUtilSDK/Assets/*.png']
  # }

  # s.public_header_files = 'Pod/Classes/**/*.h'
  # s.frameworks = 'UIKit', 'MapKit'
  s.dependency 'MPQRCoreSDK'
end
