class UsersController < ApplicationController
  before_action :authenticate_user!

  def profil
    @user = current_user
    @favorites = current_user.favorited_posts
    @posts = current_user.posts
    @post = Post.new # Pour le formulaire de création d'article
    @categories = Category.all
  end

  def update_profile
    @user = current_user
    if @user.update(user_params)
      redirect_to user_profil_path, notice: 'Profil mis à jour avec succès.'
    else
      render :profil
    end
  end

  def settings
    @categories = Category.all
  end

  def update_categories
    if params[:categories].present?
      params[:categories].each do |id, name|
        category = Category.find_by(id: id)
        category.update(name: name) if category
      end
      redirect_to user_settings_path, notice: 'Catégories mises à jour avec succès.'
    else
      flash.now[:alert] = 'Aucune catégorie à mettre à jour.'
      render :settings
    end
  end

  private

  def user_params
    params.require(:user).permit(:nickname, :email, :profile_photo)
  end
end
