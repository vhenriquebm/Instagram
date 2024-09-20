target 'InstaClone' do
  use_frameworks!
  
  pod 'Firebase/Core'
  pod 'Firebase/Database'
  pod 'Firebase/Firestore'
  pod 'Firebase/Storage'
  pod 'Firebase/Messaging'
  pod 'FirebaseAuth'
  pod 'ActiveLabel'
  pod 'SDWebImage'
  pod 'JGProgressHUD', '~> 2.2'
  pod 'YPImagePicker'
end

post_install do |installer|
    installer.generated_projects.each do |project|
        project.targets.each do |target|
            target.build_configurations.each do |config|
                config.build_settings['IPHONEOS_DEPLOYMENT_TARGET'] = '13.0'
            end
        end
    end
end
