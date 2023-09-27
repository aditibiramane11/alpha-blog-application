class UsersController < ApplicationController

  before_action :require_user, only: [:edit,:update]
   before_action :require_same_user, only: [:edit,:update, :destroy]
	def new
		@user = User.new
    end	

    def show
      @user = User.find(params[:id])
      @articles = @user.articles
    end	

    def index
      @users = User.all
      @users = User.paginate(:page => params[:page], :per_page => 5)
    end	

    def create
    	@user = User.new(user_params)
    	if  @user.save
        session[:user_id]= @user.id
    		flash[:notice] = "Welcome to the alpha blog #{@user.username}, you have successfully signed up"
    		redirect_to articles_path
        else
          render 'new'
        end  	
     end

     def edit
     	@user = User.find(params[:id])

     end

     def update
     	@user = User.find(params[:id])
     	if @user.update(user_params)
     		flash[:notice] = "Your account information was successfully updated"
    		redirect_to @user

        else
           render 'edit'
        end		
     end 

     def destroy

        @user = User.find(params[:id])
        @user.destroy
        session[:user_id]=nil if @user == current_user
        flash[:notice]="Account and all associated articles sucessfully deleted"
        redirect_to articles_path
     end




    private

    def user_params
     	params.require(:user).permit(:username,:email,:password)
    end 	

    def require_same_user
      @user = User.find(params[:id])
      if current_user != @user && !current_user.admin?
        flash[:alert]= "You can only edit or delete your own account"
        redirect_to @user
      end
    end  

    

end
