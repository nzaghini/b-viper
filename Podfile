source 'https://github.com/CocoaPods/Specs.git'

platform :ios, '8.0'
use_frameworks!

target :Weather do
  pod 'Swinject'
  pod 'Alamofire'
  pod 'ModelMapper'
  pod 'ASToast', '1.0.3'
  pod 'RealmSwift'
end

target :WeatherTests do
  pod 'Quick', '0.9.3'
  pod 'Nimble', '4.1.0'
  pod 'Swinject'
  pod 'RealmSwift'
end

post_install do |installer|
  installer.pods_project.targets.each do |target|
    target.build_configurations.each do |config|
      config.build_settings['SWIFT_VERSION'] = '2.3'
    end
  end
end