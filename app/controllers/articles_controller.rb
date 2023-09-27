class ArticlesController < ApplicationController
	before_action :set_article, only: [:show, :edit, :update, :destroy]
    before_action :require_user, except: [:show, :index]
    before_action :require_same_user, only: [:edit, :update ,:destroy]
    
    
	def show
		#@article = Article.find(params[:id])
	end
	def index
        # @articles = Article.all.paginate(page: params[:page],per_page:5)
        @articles = Article.paginate(:page => params[:page], :per_page => 5)
    end

	def new
		@article = Article.new
	end

	def edit
		#@article = Article.find(params[:id])
	end

	def destroy
		#@article = Article.find(params[:id])
		@article.destroy
		redirect_to articles_path
	end

		

	def create
		@article = Article.new(article_params)
		@article.user = current_user
		if @article.save
			flash[:notice]="Article was created sucessfully"
			redirect_to articles_path
		else
			  render "new", status: :unprocessable_entity
	    end
	end

	def update
		#@article = Article.find(params[:id])
		if @article.update(article_params)
			flash[:notice]="Article was Updated sucessfully"
			redirect_to @article
		else
			  render "edit", status: :unprocessable_entity
		end	
	end



    private

	def set_article
		@article = Article.find(params[:id])
	end	

	def article_params
		params.require(:article).permit(:Title , :Description)
	end

	def require_same_user
       if current_user.id != @article.user_id && !current_user.admin?
          flash[:alert] = "You can only edit or delete your own article"
          redirect_to @article
       end
    end
end


