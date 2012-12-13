class NotesController < ApplicationController
  before_filter :get_topic
  before_filter :get_note, :only => [:show, :edit, :update, :destroy]
  
  def get_topic
    @topic = Topic.find(params[:topic_id])
  end
  def get_note
    @note = @topic.notes.find(params[:id]) 
  end
  
  def new
    @note = Note.new
    @note.sequence = 10
    last=@topic.notes.find(:last, order: "sequence DESC", limit: 1)
    if last != nil
      @note.sequence=last.sequence + 10
    end
  end
  
  def create
    @note = @topic.notes.build(params[:note])
    if @note.save
      flash[:success] = "Note created!"
      redirect_to topic_path(@topic)
    else
      render :new
    end
  end
  
  def show
  end
  
  def edit
  end
  
    def update
      if @note.update_attributes(params[:note])
        flash[:notice] = "The note #{@note.sequence} was successfuly updated"
        redirect_to topic_note_path(@topic, @note)
      else
        render :edit
      end
  end
  
  def destroy
    @note.destroy
    flash[:notice] = "Note deleted"
    redirect_to topic_path(@topic)
  end
  
end