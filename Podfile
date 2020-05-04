# Uncomment the next line to define a global platform for your project
platform :ios, '9.0'

workspace 'CleanSpaceX'

xcodeproj 'CleanSpaceXApp/CCleanSpaceXApp.xcodeproj'
xcodeproj 'CNetwork/CNetwork.xcodeproj'

def api_pods
   pod 'Alamofire'
   pod 'KRProgressHUD'
end

def client_pods
   pod 'Alamofire'
   pod 'KRProgressHUD'
   pod 'Kingfisher'
end

target 'CleanSpaceXApp' do
  xcodeproj 'CleanSpaceXApp/CleanSpaceXApp.xcodeproj'
  client_pods
end

target 'CNetwork' do
  xcodeproj 'CNetwork/CNetwork.xcodeproj'
  api_pods
end

target 'CleanSpaceXAppTests' do
  xcodeproj 'CleanSpaceXApp/CleanSpaceXApp.xcodeproj'
  client_pods
end
