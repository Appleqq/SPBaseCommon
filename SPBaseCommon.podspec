#
#  Be sure to run `pod spec lint SPBaseCommon.podspec' to ensure this is a
#  valid spec and to remove all comments including this before submitting the spec.
#
#  To learn more about Podspec attributes see http://docs.cocoapods.org/specification.html
#  To see working Podspecs in the CocoaPods repo see https://github.com/CocoaPods/Specs/
#

Pod::Spec.new do |s|
  s.name         = "SPBaseCommon"
  s.version      = "0.0.1"
  s.summary      = "客户端工具类."
  s.description  = <<-DESC
                       内部http请求参数的生成，字符串MD5的加密，日期的格式化等
                   DESC
  s.homepage     = "https://github.com/Appleqq/SPBaseCommon"
  s.license      = "MIT"
  s.author             = { "ppan" => "820566997@qq.com" }
   s.platform     = :ios, "8.0"

  s.source       = { :git => "https://github.com/Appleqq/SPBaseCommon.git", :tag => "#{s.version}" }
  #s.source_files  = "Classes", "Classes/**/*.{h,m}"
  s.source_files = "SPCommon/*.{h,m}"
  s.framework  = "UIKit"
   s.requires_arc = true

  # s.xcconfig = { "HEADER_SEARCH_PATHS" => "$(SDKROOT)/usr/include/libxml2" }
  # s.dependency "JSONKit", "~> 1.4"

end
