# Uncomment the next line to define a global platform for your project
# platform :ios, '9.0'

def development_deps
  pod 'Network', :path => 'Network', :inhibit_warnings => false, :testspecs => ['Tests']
  pod 'UIToolKit', :path => 'UIToolKit'
  pod 'SwissKnife', :path => 'SwissKnife'
end

def external_pods
  pod 'RxSwift', '~> 5.1.1'
  pod 'RxCocoa', '~> 5.1.1'
  pod 'Action', '~> 4.1.0'
  pod 'RxDataSources'
end

target 'RxMVVMC' do
  # Comment the next line if you don't want to use dynamic frameworks
  use_frameworks!

  development_deps
  external_pods

  target 'RxMVVMCTests' do
    inherit! :search_paths
    # Pods for testing
  end

end
