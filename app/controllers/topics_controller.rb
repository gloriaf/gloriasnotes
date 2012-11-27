class TopicsController < ApplicationController
  def new
    @topic = Topic.new
  end
  
  def create
    @topic = Topic.new(params[:topic])
    if @topic.save
      redirect_to topics_path
    end  
  end
  
  def index
    @topics = Topic.all
  end
  
  def show
    @topic = Topic.find(params[:id])
  end
  
  def edit
    @topic = Topic.find params[:id]
  end
  
  def update
    @topic = Topic.find(params[:id])
    @topic.update_attributes!(params[:topic])
    flash[:notice] = "#{@topic.name} was successfuly updated"
    redirect_to topic_path(@topic)
  end
  
  def destroy
    Topic.find(params[:id]).destroy
    flash[:notice] = "Topic deleted"
    redirect_to topics_path
  end
  
end
