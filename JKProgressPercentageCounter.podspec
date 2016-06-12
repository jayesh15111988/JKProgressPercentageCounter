Pod::Spec.new do |s|
  s.name             = "JKProgressPercentageCounter"
  s.version          = "0.1"
  s.summary          = "A animating label counter to show completion progress and total percentages with interactive animation"  
  s.homepage         = "https://github.com/jayesh15111988/JKProgressPercentageCounter"
  s.license          = 'MIT'
  s.author           = { "Jayesh Kawli" => "j.kawli@gmail.com" }
  s.source           = { :git => "https://github.com/jayesh15111988/JKProgressPercentageCounter.git", :tag => '0.1' }
  s.social_media_url = 'https://twitter.com/JayeshKawli'

  s.platform     = :ios, '8.0'
  s.requires_arc = true

  s.source_files = 'JKProgressPercentageCounter/Library/*.{swift}'
end
