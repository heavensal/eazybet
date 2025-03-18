class CommentsController < ApplicationController
  def create
    @event = Event.find(params[:event_id])
    @comment = Comment.new(comment_params)
    @comment.user = current_user
    @comment.event = @event
    if @comment.save
      redirect_to event_path(@event), notice: "Votre commentaire a bien été enregistré"
    else
      redirect_back(fallback_location: event_path(@event), alert: "Erreur lors de l'enregistrement du commentaire")
    end
  end

  def show
    @event = Event.find(params[:event_id])
    @comment = Comment.find(params[:id])
  end

  def edit
    @comment = Comment.find(params[:id])
    @event = @comment.event
  end

  def update
    @comment = Comment.find(params[:id])
    @event = @comment.event
    if @comment.update(comment_params)
      redirect_to event_path(@event), notice: "Votre commentaire a bien été modifié"
    else
      redirect_back(fallback_location: event_path(@event), alert: "Erreur lors de la modification du commentaire")
    end
  end

  def destroy
    @comment = Comment.find(params[:id])
    @comment.destroy
    respond_to do |format|
      format.turbo_stream do
        render turbo_stream: turbo_stream.remove(@comment)
      end
      format.html do
        redirect_back(fallback_location: root_path, notice: "Votre commentaire a bien été supprimé")
      end
    end
  end

  private

  def comment_params
    params.require(:comment).permit(:content)
  end
end
