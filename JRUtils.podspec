Pod::Spec.new do |s|
  s.name             = 'JRUtils'
  s.version          = '0.1.1'
  s.summary          = 'JRUtils'
  s.homepage         = 'https://github.com/no33jou/JRUtils'
  s.platform         = :ios, '7.0'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'yaojunren' => 'no22jou@163.com' }
  s.source           = { :git => 'https://github.com/no33jou/JRUtils.git', :tag => s.version.to_s }
  s.source_files     = 'Utils/Utils/**/*'
  s.requires_arc     = true
  s.dependency       'MBProgressHUD'
  s.dependency       'CSNotificationView'
end
