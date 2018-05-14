platform :ios, '9.0'
inhibit_all_warnings!

target 'Foursquare' do
  use_frameworks!

  pod 'RxSwift',                  '4.0.0'
  pod 'RxCocoa',                  '4.0.0'
  pod 'ReSwift',                  '4.0.0'
  pod 'Swinject',                 '2.1.1'
  pod 'Hero',                     '1.1.0'
  pod 'SwiftLint',                '0.25.1'
  pod 'Moya/RxSwift',             '10.0.0'
  pod 'Moya-ModelMapper/RxSwift', '6.0.0'
  pod 'Kingfisher',               '4.6.2'

  target 'FoursquareTests' do
    inherit! :search_paths
    
    pod 'Moya/RxSwift',        '10.0.0'
  end

end
