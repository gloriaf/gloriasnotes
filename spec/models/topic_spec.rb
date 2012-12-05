require 'spec_helper'

describe Topic do
  before { @topic = Topic.new(:name => "Cucumber", :topic_type => "Tool", :description => "BDD", :documentation => " " ) }

  subject { @topic }

  it { should respond_to(:name) }
  it { should respond_to(:topic_type) }
  # notes
  it { should respond_to(:notes)}

  it { should be_valid }
  
  # name
  describe "when name is not present" do
    before { @topic.name = ""}
    it { should_not be_valid }
  end
  describe "when name is too long" do
    before { @topic.name = "a" * 101}
    it { should_not be_valid }
  end
  describe "when mane alredy exits" do
    before do
      topic_dup=@topic.dup
      topic_dup.name=@topic.name.upcase
      topic_dup.save
    end
    it { should_not be_valid }
  end
  
  # topic_type
  describe "when topic type is not present" do
    before { @topic.topic_type = ""}
    it { should_not be_valid }
  end
  describe "when topic type is valid" do
    it "should be valid" do
      types = %w[Tool Framework Language Other]
      types.each do |valid_topic|
        @topic.topic_type = valid_topic
        @topic.should be_valid
      end
    end
  end
  describe "when topic type is not valid" do
    it "should be valid" do
      types = %w[Tail EnglishLanguage MoreTopics]
      types.each do |invalid_topic|
        @topic.topic_type = invalid_topic
        @topic.should_not be_valid
      end
    end
  end

  # description
  describe "when description is too long" do
    before { @topic.description = "a" * 241}
    it { should_not be_valid }
  end

  # notes
  describe "note associations" do
    before { @topic.save }
    let!(:grater_note) do
      FactoryGirl.create(:note, topic: @topic, sequence: 200)
    end
    let!(:lower_note) do
      FactoryGirl.create(:note, topic: @topic, sequence: 100)
    end
    
    it "should have the lower note before grater" do
      @topic.notes.should == [lower_note, grater_note]
    end
  end

end
