require 'spec_helper'

describe NotesController do
  before :each do
    @topic=FactoryGirl.create(:topic)
  end
  
  describe "note#create - POST create" do
    
    context "whit valid attributes" do
      before :each do
        @note_attributes =  FactoryGirl.attributes_for(:note)
      end
      it "should create a new note for a topic" do
        expect {
          post :create, topic_id: @topic.id, note: @note_attributes
        }.to change(Note, :count).by(1)
      end
      it "should assigns correct values" do
        post :create, topic_id: @topic.id, note: @note_attributes
        assigns(:note).should be_a(Note)
      end
      it "should redirect to the show topic page"  do
        post :create, topic_id: @topic.id, note: @note_attributes
        response.should redirect_to topic_path(@topic)
      end
    end
    
    context "with invalid attributes" do
      before :each do
        @note_attributes =  FactoryGirl.attributes_for(:note, text: nil)
      end
      
      it "does not save the new note" do
        expect{
        post :create, topic_id: @topic.id, note: @note_attributes
        }.to_not change(Note,:count)
      end
      it "re-renders the new method" do
        post :create, topic_id: @topic.id, note: @note_attributes
        response.should render_template :new
      end
    end 
    
  end

  describe "note#show - GET show" do
    before :each do
      @note  = FactoryGirl.create(:note, topic: @topic)
    end

    it "should assigns the requested note to @note" do
      get :show, topic_id: @topic.id, id: @note.id
      assigns(:note).should eq(@note) 
    end
  end

  describe "note#edit - PUT update" do
    before :each do
      @note  = FactoryGirl.create(:note, topic: @topic)
    end
    
    context "valid attributes" do
      it "located the requested @note" do
        put :update, topic_id: @topic.id, id: @note.id, note: FactoryGirl.attributes_for(:note)
        assigns(:note).should eq(@note)
      end
      it "changes @topic's attributes" do
        put :update, topic_id: @topic.id, id: @note.id, note: FactoryGirl.attributes_for(:note, text: "Update the note")
        @note.reload
        @note.text.should eq("Update the note")
      end
      it "redirects to show" do
        put :update, topic_id: @topic.id, id: @note.id, note: FactoryGirl.attributes_for(:note)
        response.should redirect_to(topic_note_path(@topic,@note))
      end
    end
    
    context "invalid attributes" do
      before :each do
        put :update, topic_id: @topic.id, id: @note.id, note: FactoryGirl.attributes_for(:note, text: "")
      end
      
      it "does not change @note's attributes" do
        @note.reload
        @note.text.should eq("description")
      end
      it "re-renders the edit method" do
        response.should render_template :edit
      end
    end
  end

  describe "note#delete - DELETE destroy" do
    before :each do
      @note  = FactoryGirl.create(:note, topic: @topic)
    end
    
    it "should delete the note" do
      expect{ 
        delete :destroy, topic_id: @topic.id, id: @note.id
      }.to change(Note, :count).by(-1)
    end
    it "shoud redirects to topic#show" do
      delete :destroy, topic_id: @topic.id, id: @note.id
      response.should redirect_to(topic_path(@topic))
    end
  end


end
