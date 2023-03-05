Pod::Spec.new do |spec|
  spec.name         = "LoginKeychainHelper"
  spec.version      = "1.0.0"
  spec.summary      = "This is the best LoginKeychainHelper Framework."
  spec.description  = "This is the best framework ever. It will help you to store data locally to your project"

  spec.homepage     = "https://github.com/akshayparth/LoginKeychainHelper"
  spec.license      = "MIT"
  spec.author             = { "Akshay Raiyani" => "akshay.raiyani@parth.com" }
  spec.platform     = :ios, "12.0"
  spec.source       = { :git => "https://github.com/akshayparth/LoginKeychainHelper.git", :tag => spec.version.to_s }
  spec.source_files  = "LoginKeychainHelper/**/*.{swift}"
  spec.swift_versions = "5.0"
end
