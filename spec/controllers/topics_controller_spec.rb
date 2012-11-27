require 'spec_helper'

describe TopicsController do
  
  describe "#new" do
    before do
      get :new  
    end
    it "should be successfull" do
      response.should be_success
    end
    it "should create a topic object" do
      assigns(:topic).should_not be_nil  
    end
  end

  describe "#create" do
    before do
      get :create  
    end
    it "should create a new topic" do
      post :create, "topic" => {"name" => "Cucumber", "topic_type" => "Tool", "description" => "BDD tool"}
      assigns(:topic).should_not be nil
      assigns(:topic).name.should == "Cucumber"
    end
    it "should redirect to the topic list page" do
      response.should redirect_to topics_path
    end
  end
  
  describe "#index" do
    it "should be successful" do
      get :index
      response.should be_success
    end
    it "should assign a list of existing books" do
      Topic.create!(:name => "Cucumber", :topic_type => "Tool", :description => "BDD", :documentation => "")
      get :index
      assigns(:topics).should_not be nil
      assigns(:topics).length.should ==1
    end
  end
  
  describe "#show" do
    before do
      @topic = Topic.create!(:name => "Cucumber", :topic_type => "Tool", :description => "BDD", :documentation => "")
    end
    before do
      get :show, :id => @topic.id
    end
    it "should be in the rigth detail page" do
      response.should be_success
      assigns(:topic).name.should == "Cucumber"
    end
  end
  
  describe "#edit" do
    before :each do
      @t=mock(Topic, :name => "Ruby", :id => "3", :topic_type => "Language", :description => "Programing language", :documentation => "")
      Topic.stub!(:find).with("3").and_return(@t)
    end
    
    it "should be in the rigth edit page" do
      get :edit, :id => @t.id
      response.should be_success
      assigns(:topic).name.should == "Ruby"
    end
    it "should call update_attributes and redirect" do
      @t.stub!(:update_attributes!).and_return(true)
      put :update, {:id => "3", :topic => @t}
      response.should redirect_to(topic_path(@t))
    end
  end

 describe "#delete" do
    before do
      @topic=mock(Topic, :name => "Ruby", :id => "4", :topic_type => "Language", :description => "Programing language", :documentation => "")
    end

    it "should be in de index page" do
      get :index
      response.should be_success
    end   
    it "should delete the selected topic" do
      Topic.stub(:find).with("4") { @topic}
      @topic.should_receive(:destroy)
      delete :destroy, :id => "4"
      response.should redirect_to(topics_path)
    end
    
 end
end
