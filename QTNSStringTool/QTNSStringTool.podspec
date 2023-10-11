

Pod::Spec.new do |spec|


  spec.name         = "QTNSStringTool"
  spec.version      = "0.5"
  spec.summary      = "NSString分类, 封装常用方法 "

  spec.description  = "NSString分类, 封装常用方法  "

  spec.homepage     = "https://github.com/HelloBie/QTNSStringTool"


  spec.ios.deployment_target = '9.0'
  spec.license      = "MIT"

  spec.author             = { "bieqiutian" => "1005903848@qq.com" }

  spec.source       = { :git => "https://github.com/HelloBie/QTNSStringTool.git", :tag => "#{spec.version}" }


  spec.source_files  = "QTNSStringTool/QTNSStringTool/QTNSStringTool/*.{h,m}"
  
  spec.frameworks = "Foundation", "UIKit"

end
