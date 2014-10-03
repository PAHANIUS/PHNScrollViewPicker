#
#  Be sure to run `pod spec lint PHNScrollViewPicker.podspec' to ensure this is a
#  valid spec and to remove all comments including this before submitting the spec.
#
#  To learn more about Podspec attributes see http://docs.cocoapods.org/specification.html
#  To see working Podspecs in the CocoaPods repo see https://github.com/CocoaPods/Specs/
#

Pod::Spec.new do |s|

  s.name         = "PHNScrollViewPicker"
  s.version      = "1.0"
  s.summary      = "UIScrollView subclass for getting item as UIPickerView"
  s.homepage     = "https://github.com/PAHANIUS/PHNScrollViewPicker"
  s.license      = "MIT (example)"
  s.author       = { "Pavel" => "pavel.volobuev@gmail.com" }
  s.source       = { :git => "https://github.com/PAHANIUS/PHNScrollViewPicker.git", :tag => "1.0" }
  s.source_files  = "PHNScrollViewPicker", "PHNScrollViewPicker/*.{h,m}"
  s.requires_arc  = true

end
