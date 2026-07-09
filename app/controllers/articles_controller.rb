class ArticlesController < ApplicationController
  before_action :set_article, only: %i[ show edit update destroy ]
  def index
    @articles = Article.all
  end

  def show
    @article = Article.find(params[:id])
  end

  def new
    @article = Article.new
  end

  def create
    @article = Article.new(article_params)
    if @article.save
      # key value pair
      flash[:notice] = "Article successfully created! "
      redirect_to @article
    else
      render :new, status: :unprocessable_entity
    end
  end

  def edit
  end

  def update
    if @article.update(article_params)
      flash[:notice] = "Article successfully updated! "
      redirect_to article_path
    else
      render :new, status: :unprocessable_entity
    end
  end

  def destroy
    # requires set_article but not the article_params
    @article.destroy
    redirect_to articles_path
  end

  # provate allows below function to be available to this controller only
  private
    def set_article
      @article = Article.find(params[:id])
    end

    def article_params
      params.expect(article: [ :title, :description ])
    end
end
