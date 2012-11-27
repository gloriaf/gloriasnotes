require 'uri'
require 'cgi'
require File.expand_path(File.join(File.dirname(__FILE__), "..", "support", "paths"))
require File.expand_path(File.join(File.dirname(__FILE__), "..", "support", "selectors"))

Given /^the following topics exists:$/ do |topics_table|
  topics_table.hashes.each do |topic|
    Topic.create!(topic)
  end
end

When /^I click on "Remove" link for "(.*?)"$/ do |name|
  pending # express the regexp above with the code you wish you had
end