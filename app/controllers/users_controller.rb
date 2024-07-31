class UsersController < ApplicationController
  before_action :authenticate_user!

  def profil
    @user = current_user
    @favorites = current_user.favorited_posts
    @posts = current_user.posts
    @post = Post.new # Pour le formulaire de création d'article
  end

  def update_profile
    @user = current_user
    if @user.update(user_params)
      redirect_to user_profil_path, notice: 'Profil mis à jour avec succès.'
    else
      render :profil
    end
  end

  private

  def user_params
    params.require(:user).permit(:nickname, :email, :profile_photo)
  end
end
