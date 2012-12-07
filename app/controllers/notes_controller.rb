class NotesController < ApplicationController
  
  def new
    @note = Note.new
  end
  
  def create
    @topic = Topic.find(params[:topic_id])
    @note = @topic.notes.build(params[:note])
    if @note.save
      flash[:success] = "Note created!"
      redirect_to root_url
    else
      render new_topic_notes_path(@topic)
    end
  end
  
  def destroy
  end
end