# +------------------------------------+
# |                                    |
# | Podspec LAST SCRUBBED:  05-15-2019 |
# |                                    |
# +------------------------------------+
#
#  Be sure to run `pod spec lint UnIt.podspec' to ensure this is a
#  valid spec and to remove all comments including this before submitting the spec.
#
#  To learn more about Podspec attributes see http://docs.cocoapods.org/specification.html
#  To see working Podspecs in the CocoaPods repo see https://github.com/CocoaPods/Specs/
#

Pod::Spec.new do |s|
  s.name = "UnIt"
  s.version = "0.0.2"
  s.summary = "An iOS Swift framework that helps bridge the gap between UI and Unit Testing."
  s.swift_version = "4.2"
  s.description = "An iOS Swift framework that helps bridge the gap between UI and Unit Testing by providing helpful UIKit class extensions."
  s.homepage = "https://github.com/connected-io/UnIt"

  s.license = { :type => "MIT", :file => "LICENSE" }  
  s.author = { "Jonathan Yeung" => "jyeung@connected.io" }
  s.platform = :ios, "12.0"
  s.ios.deployment_target = '12.0'
  s.source = { :git => "https://github.com/connected-io/UnIt.git", :tag => "#{s.version}" }
  s.source_files = "UnIt/Source/**/*.{swift}"
  s.frameworks = 'UIKit', 'Foundation', 'XCTest'
end
