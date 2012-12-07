require 'uri'
require 'cgi'


require File.expand_path(File.join(File.dirname(__FILE__), "..", "support", "paths"))
require File.expand_path(File.join(File.dirname(__FILE__), "..", "support", "selectors"))

Given /^the following topics exists:$/ do |topics_table|
  topics_table.hashes.each do |topic|
#    Topic.create!(topic)
    FactoryGirl.create(:topic, topic)
  end
end

Given /^the following notes exists for "(.*?)"$/ do |n|
  @topic=Topic.find_by_name(n)
    FactoryGirl.create(:note, topic: @topic, sequence: 100, text: "Text 1")
    FactoryGirl.create(:note, topic: @topic, sequence: 200, text: "Text 2")
end

When /^I click on "Remove" link for "(.*?)"$/ do |name|
  pending # express the regexp above with the code you wish you had
end

Then /^I should see an error message$/ do
  page.should have_selector('div.alert.alert-error')
end

Then /^I should see "(.*)" before "(.*)"$/ do |e1, e2|
  body = page.html
  assert body.index(e1) < body.index(e2)
end

When /^I (un)?check the following topics_types: (.*?)$/ do | uncheck, types_list|
  types_list.split(',').each do |type|
    if uncheck
      uncheck("topics_types[#{type}]")
    else
      check("topics_types[#{type}]")
    end
  end
end

Then /^I should see all the topics$/ do
    page.all('table tr').count.should == Topic.count() + 1
end

Then /^I should see the (\d+) notes$/ do |cont|
  page.all('table tr').count.should == Integer(cont) + 1
end