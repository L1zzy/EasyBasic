Pod::Spec.new do |s|
s.name = 'EasyBasic'
s.version = '1.0.0'
s.license = 'MIT'
s.summary = 'Basic Objective-C files for iOS Application'
s.homepage = 'https://github.com/L1zzy/EasyBasic'
s.authors = { 'L1zzy' => '411378202@qq.com' }
s.source = { :git => "https://github.com/L1zzy/EasyBasic.git", :tag => "1.0.0"}
s.requires_arc = true
s.ios.deployment_target = '7.0'
s.source_files = 'EasyBasic/**/*.{h,m}' 
s.dependency 'MJRefresh'
s.dependency 'ReactiveCocoa'
s.dependency 'JSONModel'
s.dependency 'Masonry'
s.frameworks = 'Foundation', 'CoreGraphics', 'UIKit'  
end
