class PostsController < ApplicationController
  before_action :set_post, only: %i[ show edit update destroy ]

  # GET /posts or /posts.json
  def index
    if params[:category].present?
      @category = Category.find(params[:category])
      @posts = @category.posts.paginate(page: params[:page], per_page: 12)
    else
      @posts = Post.paginate(page: params[:page], per_page: 12)
    end
    @categories = Category.all
  end

  # GET /posts/1 or /posts/1.json
  def show
    @comments = @post.comments
    @similar_posts = Post.joins(:categories)
                         .where(categories: { id: @post.category_ids })
                         .where.not(id: @post.id)
                         .distinct
                         .limit(4)
  end

  # GET /posts/new
  def new
    @post = Post.new
  end

  # GET /posts/1/edit
  def edit
  end

  # POST /posts or /posts.json
  def create
    @post = current_user.posts.build(post_params)

    respond_to do |format|
      if @post.save
        format.html { redirect_to @post, notice: "Post was successfully created." }
        format.json { render :show, status: :created, location: @post }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @post.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /posts/1 or /posts/1.json
  def update
    respond_to do |format|
      if @post.update(post_params)
        format.html { redirect_to @post, notice: "Post was successfully updated." }
        format.json { render :show, status: :ok, location: @post }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @post.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /posts/1 or /posts/1.json
  def destroy
    @post.favorites.destroy_all
    @post.destroy
    respond_to do |format|
      format.html { redirect_to posts_url, notice: "Le post a été supprimé avec succès." }
      format.json { head :no_content }
    end
  end

  private

    # Use callbacks to share common setup or constraints between actions.
    def set_post
      @post = Post.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def post_params
      params.require(:post).permit(:title, :content, :url, :rating, :date, category_ids: [])
    end
end
