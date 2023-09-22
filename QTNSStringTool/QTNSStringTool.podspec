

Pod::Spec.new do |spec|


  spec.name         = "QTNSStringTool"
  spec.version      = "0.0.1"
  spec.summary      = "NSString 常用方法 "

  spec.description  = <<-DESC
                   DESC

  spec.homepage     = "https://github.com/HelloBie/QTNSStringTool"



  spec.license      = "MIT (example)"

  spec.author             = { "bieqiutian" => "1005903848@qq.com" }

  spec.source       = { :git => "http://EXAMPLE/QTNSStringTool.git", :tag => "#{spec.version}" }


  spec.source_files  = "QTNSStringTool/QTNSStringTool/QTNSStringTool/*.{h,m}"
  
  spec.frameworks = "Foundation", "UIKit"

end
