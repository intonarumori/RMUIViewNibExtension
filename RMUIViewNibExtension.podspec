Pod::Spec.new do |s|
  s.name = "RMUIViewNibExtension"
  s.version = "0.0.2"
  s.summary = "Swift extension for initializing UIViews from nib files in a typed manner."
  s.homepage = "https://github.com/intonarumori/RMUIViewNibExtension"
  s.license = { :type => "MIT", :file => "LICENSE.md" }
  s.authors = "Daniel Langh"
  s.ios.deployment_target = "8.0"
  s.source = { :git => "https://github.com/intonarumori/RMUIViewNibExtension.git", :tag => "#{s.version}" }
  s.source_files = 'RMUIViewNibExtension/*.swift'
end
