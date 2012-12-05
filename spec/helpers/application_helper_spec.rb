require 'spec_helper'

describe ApplicationHelper do
  
  it "should do full_title" do
    helper.full_title('Edit topic').should == 'Gloria\'s Notes | Edit topic'
  end

end
