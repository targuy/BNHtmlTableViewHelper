Pod::Spec.new do |s|
  s.name         = "BNHtmlTableViewHelper"
  s.version      = "0.1.0"
  s.dependency	 'hpple'
  s.dependency	 'BlocksKit'
  s.summary      = "Class to help a UITableViewController to manage an HTML Table from a website as a datasource "
  s.description  = <<-DESC
                    An optional longer description of BNHtmlTableViewHelper

                    * Markdown format.
                    * Don't worry about the indent, we strip it!
                   DESC
  s.homepage     = "https://github.com/targuy/BNHtmlTableViewHelper"
  s.screenshots  = "www.example.com/screenshots_1", "www.example.com/screenshots_2"
  s.license      = 'MIT'
  s.author       = { "targuy" => "benoit@familleguitard.fr" }
  s.platform     = :ios
  s.ios.deployment_target = "7.0"
  s.source       = { :git => "https://github.com/targuy/BNHtmlTableViewHelper.git", :tag => s.version.to_s }
  s.requires_arc = true

  s.source_files = 'Classes'
  s.resources = 'Assets'

  s.ios.exclude_files = 'Classes/osx'
  s.osx.exclude_files = 'Classes/ios'
  s.public_header_files = 'Classes/**/*.h'
end
