require 'spec_helper'

describe Note do
  
  let(:topic) { FactoryGirl.create(:topic) }
  before do
    @note = topic.notes.build(sequence: 1, text: "nota")
  end
  
  subject { @note }
  
  it { should respond_to(:sequence) }
  it { should respond_to(:text) }
  it { should respond_to(:topic_id) }
  it { should respond_to(:topic) }
  its(:topic) { should == topic}
  
  it { should be_valid }
  
  describe "accesible attributes" do
    it "should not allow access to topic_id" do
      expect do
        Note.new(topic_id: topic.id)
      end.to raise_error(ActiveModel::MassAssignmentSecurity::Error)
    end
  end
  
  describe "when topic_id is not present" do
    before { @note.topic_id = nil }
    it { should_not be_valid }
  end

  describe "without  sequence" do
    before {@note.sequence = 0}
    it { should_not be_valid }
  end

  describe "repeated sequence" do
    before do
      @note2 = topic.notes.build(sequence: 1, text: "nota")
      @note2.save!
    end
    it { should_not be_valid }
  end
  
  describe "with blank text" do
    before {@note.text = ""}
    it { should_not be_valid }
  end
end
