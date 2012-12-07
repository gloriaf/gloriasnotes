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

  
  describe "#index - GET index" do
    it "populates an array of topics" do
      topic = FactoryGirl.create(:topic)
      get :index
      response.should be_success
      assigns(:topics).should eq([topic])
    end
    it "should rendes the :index view" do
      get :index
      response.should render_template :index
    end
  end
  
  describe "#show - GET show" do
    it "should assigns the requested topic to @topic" do
      topic = FactoryGirl.create(:topic)
      get :show, id: topic
      assigns(:topic).should eq(topic) 
    end
    it "should renders the :show view" do
      get :show, id: FactoryGirl.create(:topic)
      response.should render_template :show
    end
    it "should have notes" do
      topic = FactoryGirl.create(:topic)
      n1 = FactoryGirl.create(:note, topic: topic, sequence: 100, text: "text 1") 
      n2 = FactoryGirl.create(:note, topic: topic, sequence: 200, text: "text 2")
      get :show, id: topic
      topic.notes.count.should == 2
    end
  end
  
  describe "#edit" do
    before :each do
      @topic = FactoryGirl.create(:topic, name: "Ruby")
    end
    it "located the requested @topic" do
      put :edit, id: @topic, topic: FactoryGirl.attributes_for(:topic)
      assigns(:topic).should eq(@topic)
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

  describe "sort index by column and direcction parameters" do
    before :each do
      @topics = [ FactoryGirl.create(:topic, name: "Cucumber"), FactoryGirl.create(:topic, name: "Git") ]
      @selected_topic_types = Hash[ 'Tool', 'Tool']
    end
    it "should call the model method that present de index with the apropiate parameters" do
      Topic.should_receive(:find_all_by_topic_type).with(@selected_topic_types.keys, {:order => 'name asc'}).and_return(@topics)
      post :index, {:sort_column => 'name', :sort_direction => 'asc', :topics_types => @selected_topic_types}
    end
    describe "valid data order" do
      before :each do
        Topic.should_receive(:find_all_by_topic_type).with(@selected_topic_types.keys , {:order => 'name asc'}).and_return(@topics)
        post :index, {:sort_column => 'name', :sort_direction => 'asc', :topics_types => @selected_topic_types}
      end
      it "should select de index template for rendering" do
        response.should render_template :index
      end
      it "should make the results available to that template" do
        assigns(:topics).should eq(@topics)
      end
    end
  end
  
  describe "filter topics action" do
    before :each do
      FactoryGirl.create(:topic, name: "Rails", topic_type: 'Language')
      @topics=[FactoryGirl.create(:topic, name: "Cucumber", topic_type: 'Tool')]
      @selected_topic_types = Hash[ 'Tool', 'Tool']
    end

    it "should call the model method that filter de topics by topic type" do
      Topic.should_receive(:find_all_by_topic_type).with(@selected_topic_types.keys, {:order => 'name asc'}).and_return(@topics)
      post :index, {:sort_column => 'name', :sort_direction => 'asc', :topics_types => @selected_topic_types}
    end
    it "should select de index template for rendering" do
        Topic.should_receive(:find_all_by_topic_type).with(@selected_topic_types.keys , {:order => 'name asc'}).and_return(@topics)
        post :index, {:sort_column => 'name', :sort_direction => 'asc', :topics_types => @selected_topic_types}
        response.should render_template :index
    end
    it "should make the results available to that template" do
        Topic.should_receive(:find_all_by_topic_type).with(@selected_topic_types.keys , {:order => 'name asc'}).and_return(@topics)
        post :index, {:sort_column => 'name', :sort_direction => 'asc', :topics_types => @selected_topic_types}
        assigns[:topics].should_not be_empty
        assigns[:topics].should have(1).records
    end
  end
end
