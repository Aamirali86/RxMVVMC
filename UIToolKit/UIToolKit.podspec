Pod::Spec.new do |spec|

  spec.name                     = 'UIToolKit'
  spec.version                  = '2.7.6'
  spec.authors                  = { 'Aamir' => 'aamir-muhammad@hotmail.com' }
  spec.summary                  = 'UIToolKit'

  spec.homepage                 = 'https://github.com/aamirali86'
  spec.author                   = { 'Aamir' => 'aamir-muhammad@hotmail.com' }
  spec.source                   = { :git => 'https://github.com/Aamirali86/RxMVVMC.git', :tag => spec.version.to_s }

  spec.swift_version            = '5.0'
  spec.ios.deployment_target    = '11.0'

  spec.resources 		            = 'UIToolKit/**/*.{xcassets,strings,storyboard,xib}'
  spec.frameworks 		          = 'UIKit'

  spec.source_files 	          = ['UIToolKit/**/*.{swift}']

end
