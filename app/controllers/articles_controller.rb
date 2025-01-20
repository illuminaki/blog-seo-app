class ArticlesController < ApplicationController
  before_action :set_article, only: %i[ show edit update destroy ]

  # GET /articles
  def index
    @articles = Article.all
  end

  # GET /articles/1
  def show
  end

  # GET /articles/new
  def new
    @article = Article.new
  end

  # GET /articles/1/edit
  def edit
  end

  # POST /articles
  def create
    @article = Article.new(article_params)

    if @article.save
      redirect_to article_path(@article), notice: "Article was successfully created."
    else
      render :new, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /articles/1
  def update
    if @article.update(article_params)
      redirect_to article_path(@article), notice: "Article was successfully updated."
    else
      render :edit, status: :unprocessable_entity
    end
  end


  # DELETE /articles/1
  def destroy
    @article.destroy!
    redirect_to articles_url, notice: "Article was successfully destroyed.", status: :see_other
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_article
      @article = Article.friendly.find(params[:id])
    end

    # Set meta tags for the show action
    def set_meta_tags
      @article = Article.friendly.find(params[:id])

      # Set dynamic meta tags
      content_for :title, @article.title
      content_for :meta_description, @article.meta_description
      content_for :image_url, url_for(@article.image) if @article.image.attached?
    end

    # Only allow a list of trusted parameters through.
    def article_params
      params.require(:article).permit(:title, :content, :slug, :meta_description)
    end
end
