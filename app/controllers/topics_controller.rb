class TopicsController < ApplicationController
  helper_method :sort_column, :sort_direction, :filter_types

  before_filter :get_topic

  def get_topic
    @topic = Topic.find(params[:id])
  end

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
    @all_topic_types = Topic.all_topic_types
    @selected_topic_types = params[:topics_types] || {}
    
    if @selected_topic_types == {}
      @selected_topic_types = Hash[ @all_topic_types.map { |type| [type, type]}]
    end

    @topics = Topic.find_all_by_topic_type(@selected_topic_types.keys, :order => sort_column + ' ' + sort_direction )
  end
  
  def show
    @notes = @topic.notes.paginate(page: params[:page], per_page: 15)
  end
  
  def edit
    
  end
  
  def update
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
