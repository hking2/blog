class ArticlesController < ApplicationController
  before_action :set_article, only: [
    :show, :edit, :update, :destroy
  ]

  def show #get
  end

  def index
    @articles = Article.all
  end

  def new
    @article = Article.new
  end

  def edit
  end

  def create
    @article = Article.new(article_params)
    if @article.save
      flash[:notice] = "Submission Success"
      redirect_to article_path(@article)
    else
      render 'new'
    end
  end

  def update
    if @article.update(article_params)
    flash[:notice] = "Edit Updated"
    redirect_to @article
    else
      render 'edit'
    end
  end

  def destroy #delete
    @article.destroy
    redirect_to articles_path
  end

  private #any code below private is scoped within Class only

  def set_article
    @article = Article.find(params[:id])
  end

  def article_params
    params.require(:article).permit( :title, :description )
  end

end