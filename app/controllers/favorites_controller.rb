class FavoritesController < ApplicationController
  before_action :authenticate_user!
  before_action :set_post

  def create
    current_user.favorites.create(post: @post)
    respond_to do |format|
      format.html { redirect_to posts_path, notice: "Added to favorites." }
      format.turbo_stream { render turbo_stream: turbo_stream.replace("favorite_#{@post.id}", partial: "posts/favorite", locals: { post: @post }) }
    end
  end

  def destroy
    favorite = current_user.favorites.find_by(post: @post)
    favorite.destroy
    respond_to do |format|
      format.html { redirect_to posts_path, notice: "Removed from favorites." }
      format.turbo_stream { render turbo_stream: turbo_stream.replace("favorite_#{@post.id}", partial: "posts/favorite", locals: { post: @post }) }
    end
  end

  private

  def set_post
    @post = Post.find(params[:post_id])
  end
end
