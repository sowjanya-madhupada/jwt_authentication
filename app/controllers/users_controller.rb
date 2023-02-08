class UsersController < ApplicationController
	before_action :set_user, only: %i[show destroy update]
	before_action :authenticate_request, except: %i[create]
    
    def index 
    	@users = User.all 
    	render json: @users, status: :ok
    end

    def show  
    	render json: @user, status: :ok
    end


    def create 
    	@user = User.new(user_params)
    	if @user.save 
    		render json: @user, status: :created
    	else
    		render json: { errors: @user.errors.full_messages }, status: :unprocessable_entity
    	end 
    end

    def update 
    	@user.update(user_params)
    	if @user.save 
    		render json: @user, status: :updated  
    	else 
    		render json: { errors: @user.errors.full_messages }, status: :unprocessable_entity
    	end
    end

    def destroy 
    	@user.destroy
    end 



	private

	    def user_params
	    	params.permit(:name, :email, :password)
	    end

	    def set_user
	    	@user = User.find(params[:id]) 
	    end
end
