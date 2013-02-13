Pod::Spec.new do |s|
  s.name         = "MNStaticTableViewController"
  s.version      = "0.0.1"
  s.summary      = "MNStaticTableViewController is a UITableViewController optimized for creating a tableview with static sections."
  s.homepage     = "https://github.com/madninja/MNStaticTableViewController"
  s.license      = 'BSD'
  s.author       = { 
  	"Marc Nijdam" => "http://imadjine.com" 
  }
  s.source       = { 
  	:git => "https://github.com/madninja/MNStaticTableViewController.git", 
  	:branch => "master" 
  }
  s.source_files = 'MNStaticTableViewController/MNStaticTableViewController.{h,m}'
  s.requires_arc = true

  s.platform     = :ios, '5.0'
end
