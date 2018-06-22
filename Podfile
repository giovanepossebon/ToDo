platform :ios, '10.0'

target 'ToDo' do
  use_frameworks!
  inhibit_all_warnings!

  pod 'Alamofire', '~> 4.7'
  pod 'KeychainSwift', '~> 11.0'

  target 'ToDoTests' do
    pod 'Quick'
    pod 'Nimble'

    inherit! :search_paths

  end

  target 'ToDoUITests' do
    inherit! :search_paths

  end

end
