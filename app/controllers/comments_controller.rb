class CommentsController < ApplicationController
  before_action :logged_in_user, only: [:create]
  def show
    
  end
  def create

    @entry = Entry.find(params[:entry_id])
    if current_user.following?(@entry.user) || current_user?(@entry.user)
    	@comment = @entry.comments.build(comment_params)
    	@comment.user = current_user
   	  @comment.save
   	  respond_to do |format|
        format.html { redirect_to @entry }
        format.js
      end
    else
      respond_to do |format|
        format.html { redirect_to @entry }
        format.js { render inline: "alert('You cannot comment!');" }
      end
    end
  end

  def edit
    @entry = Entry.find(params[:entry_id])
    @comment = Comment.find(params[:comment_id])
  end

  def update
    @entry = Entry.find(params[:entry_id])
    @comment = Comment.find(params[:comment_id])
    if !@entry.update(comment_params)
      flash[:alert] = 'Comment was not edit'
    end
    redirect_to @entry
  end


  def destroy

    @comment = Comment.find(params[:id])
    entry = @comment.entry
    @comment.destroy
    flash[:success] = 'successfully destroyed.'
    respond_to do |format|
      format.html { redirect_to entry }
      format.json { head :no_content }
    end
  end

  private
  def comment_params
  	params.require(:comment).permit(:entry_id,:content,:user_id)
  end

end
