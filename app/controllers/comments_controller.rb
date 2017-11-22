class CommentsController < ApplicationController
  before_action :require_user
  
  def create
    @todo = Todo.find(params[:todo_id])
    @comment = @todo.comments.build(comment_params)
    @comment.user = current_user
    if @comment.save
      ActionCable.server.broadcast "comments", render(partial: 'comments/comment', object: @comment)
      #flash[:success] = "Comment was created successfully"
      #redirect_to todo_path(@todo)
    else
      flash[:danger] = "Comment was not created"
      redirect_to :back
    end
  end
  
  private
  
  def comment_params
    params.require(:comment).permit(:description)
  end
  
end