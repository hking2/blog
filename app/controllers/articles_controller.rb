class ArticlesController < ApplicationController
  before_action :set_article, only: [
    :show, :edit, :update, :destroy
  ]
  before_action :require_user, except: [
    :show, :index
  ]
  before_action :require_owner, only: [
    :edit, :update, :destroy
  ]

  def show #get
  end

  def index
    @articles = Article.paginate(page: params[:page], per_page: 5)
  end

  def new #serves (GET) new form
    @article = Article.new
  end

  def create #takes new form data to create (POST) resource in DB
    @article = Article.new(article_params)
    @article.user = current_user
    if @article.save
      flash[:notice] = "Submission Success"
      redirect_to article_path(@article)
    else
      render 'new'
    end
  end

  def edit #serves (GET) edit form
  end

  def update #takes edit form data to update (POST) resource in DB
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

  def require_owner
    if current_user != @article.user && !current_user.admin?
      flash[:alert] = "You are not the owner of this article"
      redirect_to @article
    end
  end

end