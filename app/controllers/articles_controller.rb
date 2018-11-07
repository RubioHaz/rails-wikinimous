class ArticlesController < ApplicationController
  before_action :set_article, only: %i[show edit update destroy]
  before_action :validate_article, only: [:create]

  def index
    @articles = Article.all
  end

  def show; end

  def new
    @article = Article.new
  end

  def create
    redirect_to articles_path
  end

  def edit; end

  def update
    @article.update(article_params)
    redirect_to articles_path
  end

  def destroy
    @article.destroy
    redirect_to articles_path
  end

  private

  def article_params
    params.require(:article).permit(:title, :content)
  end

  def set_article
    @article = Article.find(params[:id])
  end

  def validate_article
    @article = Article.new(article_params)
    @article.save
    unless @article.valid? render(
      html: "
      <div class='container'>
        <h4 class='frown'>
          <i class='fa fa-frown-o' aria-hidden='true'></i>
          You received the following error:
        </h4><br>
        <p>
          --------- <em class='error'>#{@article.errors.messages}</em> ---------
        </p>
        <hr>
        <a href='/'>
          back home
        <a>
      </div>".html_safe,
      layout: 'application'
    )
    end
  end
end
