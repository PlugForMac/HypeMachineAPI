Pod::Spec.new do |s|
  s.name         = "HypeMachineAPI"
  s.version      = "1.1.0"
  s.summary      = "This is a partial implementation of the Hype Machine API in Swift."
  s.homepage     = "https://github.com/PlugForMac/HypeMachineAPI"
  s.license      = { :type => "MIT", :file => "LICENSE" }
  s.author       = { "Alex Marchant" => "alexjmarchant@gmail.com" }
  s.platform     = :osx, "10.11"
  s.source       = { :git => "https://github.com/PlugForMac/HypeMachineAPI.git", :tag => s.version }
  s.source_files = 'Source/*.swift'
  s.requires_arc = true
  s.dependency "Alamofire", "~> 4.0.1"
  s.dependency "CryptoSwift", "~> 0.10.0"
end
