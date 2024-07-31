# app/controllers/users_controller.rb
class UsersController < ApplicationController
  before_action :authenticate_user!

  def profil
    @user = current_user
    @favorites = current_user.favorited_posts
    @posts = current_user.posts
    @post = Post.new # Assurez-vous que @post est initialisé
  end
end
