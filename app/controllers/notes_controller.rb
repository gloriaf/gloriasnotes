class NotesController < ApplicationController
  
  def new
    @topic = Topic.find(params[:topic_id])
    @note = Note.new
    @note.sequence = 10
    last=@topic.notes.find(:last, order: "sequence DESC", limit: 1)
    if last != nil
      @note.sequence=last.sequence + 10
    end
  end
  
  def create
    @topic = Topic.find(params[:topic_id])
    @note = @topic.notes.build(params[:note])
    if @note.save
      flash[:success] = "Note created!"
      redirect_to topic_path(@topic)
    else
      render :new
    end
  end
  
  def show
    @topic = Topic.find(params[:topic_id])
    @note = @topic.notes.find(params[:id])
  end
  
  def edit
    @topic = Topic.find(params[:topic_id])
    @note = @topic.notes.find(params[:id])
  end
  
    def update
      @topic = Topic.find(params[:topic_id])
      @note = @topic.notes.find(params[:id])
      if @note.update_attributes(params[:note])
        flash[:notice] = "The note #{@note.sequence} was successfuly updated"
        redirect_to topic_note_path(@topic, @note)
      else
        render :edit
      end
  end
  
  def destroy
    @topic = Topic.find(params[:topic_id])
    @topic.notes.find(params[:id]).destroy
    flash[:notice] = "Note deleted"
    redirect_to topic_path(@topic)
  end
  
end