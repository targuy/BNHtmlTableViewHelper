Pod::Spec.new do |s|
  s.name         = "BNHtmlTableViewHelper"
  s.version      = "0.0.1"
  s.dependency	 'hpple'
  s.dependency	 'BlocksKit'
  s.summary      = "Class to help a UITableViewController to manage an HTML Table from a website as a datasource "
  s.description  = <<-DESC
                   A longer description of BNHtmlTableViewHelper in Markdown format.

                   * Think: Why did you write this? What is the focus? What does it do?
                   * CocoaPods will be using this to generate tags, and improve search results.
                   * Try to keep it short, snappy and to the point.
                   * Finally, don't worry about the indent, CocoaPods strips it!
                   DESC

 s.homepage     = "https://github.com/targuy/BNHtmlTableViewHelper"
  s.license = { :type => 'MIT', :file => 'LICENSE.txt' } 
 s.author       = { "targuy" => "benoit@familleguitard.fr" }
 s.platform     = :ios
 s.ios.deployment_target = "7.0"
 s.source       = { :git => "https://github.com/targuy/BNHtmlTableViewHelper.git", :commit => "a98476ae48109872a0bb91c555e9d7b070abe562" }
 s.source_files  = 'Classes', '*.{h,m}'
 s.public_header_files = 'Classes/**/*.h'
end
