Pod::Spec.new do |spec|
    spec.name                   = 'SwissKnife'
    spec.version                = '0.1.11'
    spec.summary                = 'Collection of reusable extensions and helper functions'

    spec.homepage               = 'https://github.com/aamirali86'
    spec.author                 = { 'Aamir' => 'aamir-muhammad@hotmail.com' }
    spec.source                 = { :git => 'https://github.com/Aamirali86/RxMVVMC.git', :tag => spec.version.to_s }

    spec.ios.deployment_target  = '11.0'
    spec.swift_version          = '5'

    spec.source_files           = 'SwissKnife/**/*.{swift}'
    spec.resources              = 'SwissKnife/**/*.{xcassets,strings}'
    spec.dependency               'RxSwift', '~> 5.1.1'
    spec.dependency               'RxCocoa', '~> 5.1.1'
    
end
