class TopicsController < ApplicationController

  helper_method :sort_column, :sort_direction

  def new
    @topic = Topic.new
  end
  
  def create
    @topic = Topic.new(params[:topic])
    if @topic.save
      redirect_to topics_path
    else
      render new_topic_path
    end  
  end
  
  def index
    @topics = Topic.order(sort_column + ' ' + sort_direction )
  end
  
  def show
    @topic = Topic.find(params[:id])
  end
  
  def edit
    @topic = Topic.find params[:id]
  end
  
  def update
    @topic = Topic.find(params[:id])
    if @topic.update_attributes(params[:topic])
#      flash[:notice] = "#{@topic.name} was successfuly updated"
      redirect_to topic_path(@topic)
    else
      render 'edit'
    end
  end
  
  def destroy
    Topic.find(params[:id]).destroy
    flash[:notice] = "Topic deleted"
    redirect_to topics_path
  end
  
  private
  def sort_column
    Topic.column_names.include?(params[:sort]) ? params[:sort] : "name"
  end
  def sort_direction
    %w[asc desc].include?(params[:direction]) ?  params[:direction] : "asc"
  end
  
end
