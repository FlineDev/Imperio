Pod::Spec.new do |s|

  s.name         = "Imperio"
  s.version      = "1.0.1"
  s.summary      = "Keep the screen flow and data handling logic out of your view controllers."

  s.description  = <<-DESC
    The goal of this library is to keep view controllers lean by getting screen flow and data handling logic out of them.
    Instead coordinators are used to handle screen flow and trigger data handling.
    This idea is explored in detail by Soroush Khanlou in his great posts. Go ahead and read it now if you haven't already!
                   DESC

  s.homepage     = "https://github.com/Flinesoft/Imperio"
  s.license      = { :type => "MIT", :file => "LICENSE.md" }

  s.author             = { "Cihat Gündüz" => "CihatGuenduez@posteo.de" }
  s.social_media_url   = "https://twitter.com/Dschee"

  s.ios.deployment_target = "8.0"
  s.tvos.deployment_target = "9.0"

  s.source       = { :git => "https://github.com/Flinesoft/Imperio.git", :tag => "#{s.version}" }
  s.source_files = "Sources", "Sources/**/*.swift"
  s.framework    = "UIKit"

end
