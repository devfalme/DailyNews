project 'DailyNews.xcodeproj'
platform :ios, '10.0'
inhibit_all_warnings!

target 'DailyNews' do

  # use_frameworks!
  pod 'AFNetworking'
  pod 'Xor_t', '~>0.0.1'
  pod 'Router_t', '~>0.1.0'
  pod 'ReactiveCocoa', '2.5'
  pod 'YYModel'
  pod 'Masonry'
  pod 'QMUIKit'
  pod 'SDWebImage'
  pod 'MJRefresh'
  pod 'CWLateralSlide', '~> 1.6.4'
  pod 'UMCCommon'
  pod 'UMCPush'
  pod 'UMCSecurityPlugins'
  pod 'UMCShare/UI'
  pod 'UMCShare/Social/WeChat'
  pod 'UMCShare/Social/QQ'
  pod 'UMCShare/Social/Sina'
  pod 'UMCShare/Social/Facebook'
  pod 'UMCShare/Social/Twitter'
  pod 'UMCShare/Social/AlipayShare'
  pod 'UMCShare/Social/DingDing'
  pod 'UMCShare/Social/Douban'
  pod 'UMCShare/Social/Renren'
  pod 'UMCShare/Social/TencentWeibo'
  pod 'UMCShare/Social/Flickr'
  pod 'UMCShare/Social/Kakao'
  pod 'UMCShare/Social/Tumblr'
  pod 'UMCShare/Social/Instagram'
  pod 'UMCShare/Social/Line'
  pod 'UMCShare/Social/WhatsApp'
  pod 'UMCShare/Social/GooglePlus'
  pod 'UMCShare/Social/SMS'
  pod 'UMCShare/Social/Email'
  pod 'UMCShare/Social/VKontakte'
end
post_install do |installer|
  installer.pods_project.targets.each do |target|
 target.build_configurations.each do |config|
  if config.build_settings['IPHONEOS_DEPLOYMENT_TARGET'].to_f < 8.0
    config.build_settings['IPHONEOS_DEPLOYMENT_TARGET'] = '8.0'
     end
   end
  end
end
