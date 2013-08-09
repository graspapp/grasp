class UsersController < ApplicationController

	before_filter :get_user, :only => [:index, :new, :edit]
	before_filter :accessible_roles, :only => [:new, :edit, 
				  :show, :update, :create]
	load_and_authorize_resource :only => [:show, :new, :destroy, :edit, :update]

	def index
		@users = User.accessible_by(current_ability, :index).limit(20)
	end

	def new
    respond_with_formats
	end

	def show
    respond_with_formats
	end

	def edit
    respond_with_formats
	end

	def destroy
		@user.destroy!
    respond_to_destroy_with_formats
	end

	def create
		@user = User.new(param[:user])

		if @user.save
			respond_to do |format|
				format.json { render :json => @user.to_json, :status => 200 }
				format.xml { head :ok }
				format.html { redirect_to :action => :index }
			end
		else
			respond_to do |format|
				format.json { render :text => "Could not create user", 
									 :status => :unprocessable_entity}
				format.xml { head :ok }
				format.html {render :action => :new, 
								 	:status => :unprocessable_entity}
			end
		end
	end

	def update
		if params[:user][:password].blank?
			[:password, :password_confirmation,:current_password].collect{
				|p| params[:user].delete(p)	}
		else
      unless @user.valid_password?(params[:user][:current_password])
        @user.errors[:base] << "The password you entered is incorrect"
      end
		end

		respond_to do |format|
			if @user.errors[:base].empty? and
        @user.update_attributes(params[:user])
				flash[:notice] = "Your account has been updated"
				format.json { render :json => @user.to_json, :status => 200 }
				format.xml { head :ok }
				format.html { render :action => :edit }
			else
				format.json { render :text => "Could not update user", 
					:status => :unprocessable_entity }
				format.xml { render :xml => @user.errors, 
					:status => :unprocessable_entity }
				format.json { render :action => :edit, 
					:status => :unprocessable_entity }
			end
		end
	end

  def respond_with_formats
		respond_to do |format|
			format.json { render :json => @user }
			format.xml { render :xml => @user }
			format.html
		end
  end

  def respond_to_destroy_with_formats
		respond_to do |format|
			format.json { respond_to_destroy(:ajax) }
			format.xml { head :ok }
			format.html {respond_to_destroy(:html)}
		end
  end
end
