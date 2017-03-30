source 'https://rubygems.org'

<% if enable_settings && dependency_manager_enabled?("cocoapods") %>
gem "cocoapods", "1.2.0"
<% end %>
gem 'xcpretty'
