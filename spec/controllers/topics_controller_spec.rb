require 'spec_helper'

describe TopicsController do
  
  describe "#new - GET new" do
    before { get :new }
    
    it "should create a topic object" do
      assigns(:topic).should_not be_nil  
    end
  end

  describe "#create - POST create" do
    context "whit valid attributes" do
      it "should create a new topic" do
        expect {
          post :create, topic: FactoryGirl.attributes_for(:topic)
        }.to change(Topic, :count).by(1)
      end
      it "should redirect to the topic list page" do
        post :create, topic: FactoryGirl.attributes_for(:topic)
        response.should redirect_to topics_path
      end
    end
    
    context "with invalid attributes" do
      it "does not save the new topic" do
        expect{
          post :create, topic: FactoryGirl.attributes_for(:topic, name: nil)
        }.to_not change(Topic,:count)
      end
      it "re-renders the new method" do
        post :create, topic: FactoryGirl.attributes_for(:topic, name: nil)
        response.should render_template :new
      end
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
    before { @topic = Topic.create!(:name => "Cucumber", :topic_type => "Tool", :description => "BDD", :documentation => "") }
    before { get :show, :id => @topic.id }

    it "should be in the rigth detail page" do
      response.should be_success
      assigns(:topic).name.should == "Cucumber"
    end
  end
  
  describe "#edit - PUT update" do
    before :each do
      @topic = FactoryGirl.create(:topic, name: "Ruby")
    end
    
    context "valid attributes" do
      it "located the requested @topic" do
        put :update, id: @topic, topic: FactoryGirl.attributes_for(:topic)
        assigns(:topic).should eq(@topic)
      end
      it "changes @topic's attributes" do
        put :update, id: @topic, topic: FactoryGirl.attributes_for(:topic, name: "Java")
        @topic.reload
        @topic.name.should eq("Java")
      end
      it "redirects to show" do
        put :update, id: @topic, topic: FactoryGirl.attributes_for(:topic)
        response.should redirect_to(topic_path(@topic))
      end
    end
    
    context "invalid attributes" do
      it "locates the requested @topic" do
        put :update, id: @topic, topic: FactoryGirl.attributes_for(:topic, name: nil)
        assigns(:topic).should eq(@topic)      
      end
      it "does not change @topic's attributes" do
        put :update, id: @topic, 
         topic: FactoryGirl.attributes_for(:topic, name: "Java", topic_type: nil)
        @topic.reload
        @topic.name.should_not eq("Java")
      end
      it "re-renders the edit method" do
        put :update, id: @topic, topic: FactoryGirl.attributes_for(:topic, name: nil)
        response.should render_template :edit
      end
    end
  end

 describe "#delete - DELETE destroy" do
    before :each do
      @topic = FactoryGirl.create(:topic)
    end
    
    it "should delete the topic" do
      expect{
        delete :destroy, id: @topic
      }.to change(Topic, :count).by(-1)
    end
    it "shoud redirects to topics#index" do
      delete :destroy, id: @topic
      response.should redirect_to(topics_path)
    end
 end
 
end
