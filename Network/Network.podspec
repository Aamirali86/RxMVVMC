Pod::Spec.new do |spec|
    spec.name                   = 'Network'
    spec.version                = '0.1.0'
    spec.summary                = 'Network framework'

    spec.homepage               = 'https://github.com/aamirali86'
    spec.author                 = { 'Aamir' => 'aamir-muhammad@hotmail.com' }
    spec.source                 = { :git => 'https://github.com/Aamirali86/RxMVVMC.git', :tag => spec.version.to_s }

    spec.ios.deployment_target  = '11.0'
    spec.static_framework       = true

    spec.source_files           = 'Sources/**/*.{swift}'

    spec.dependency             'RxSwift', '~> 5.0'
    spec.dependency             'RxCocoa', '~> 5.0'

    spec.test_spec  'Tests' do |test_spec|
        test_spec.source_files  = 'Tests/**/*.{swift}'
        test_spec.dependency    'RxTest'
    end
end
