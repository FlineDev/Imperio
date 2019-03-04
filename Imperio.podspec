Pod::Spec.new do |s|

  s.name         = "Imperio"
  s.version      = "3.0.1"
  s.summary      = "Keep the screen flow logic out of your view controllers & make them testable."

  s.description  = <<-DESC
    The goal of this library is to keep view controllers lean & make them easily testable by getting screen flow and other responsibilities out of them.
    Instead coordinators are used to handle screen flow and trigger changes in the view part, which the view controller handles.
    Pattern wise this approach combines ideas from MVC, MVP, MVVM and VIPER.
                   DESC

  s.homepage     = "https://github.com/Flinesoft/Imperio"
  s.license      = { :type => "MIT", :file => "LICENSE" }

  s.author             = { "Cihat Gündüz" => "cocoapods@cihatguenduez.de" }
  s.social_media_url   = "https://twitter.com/Dschee"

  s.ios.deployment_target = "8.0"
  s.tvos.deployment_target = "9.0"

  s.source       = { :git => "https://github.com/Flinesoft/Imperio.git", :tag => "#{s.version}" }
  s.source_files = "Frameworks/Imperio/**/*.swift"
  s.framework    = "UIKit"

  s.swift_version = "4.2"
end
