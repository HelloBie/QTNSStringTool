

Pod::Spec.new do |spec|


  spec.name         = "QTNSStringTool"
  spec.version      = "0.0.3"
  spec.summary      = "NSString 常用方法 "

  spec.description  = "QTQuickSetupUI"

  spec.homepage     = "https://github.com/HelloBie/QTNSStringTool"



  spec.license      = "MIT"

  spec.author             = { "bieqiutian" => "1005903848@qq.com" }

  spec.source       = { :git => "https://github.com/HelloBie/QTNSStringTool.git", :tag => "#{spec.version}" }


  spec.source_files  = "QTNSStringTool/QTNSStringTool/*.{h,m}"
  
  spec.frameworks = "Foundation", "UIKit"

end