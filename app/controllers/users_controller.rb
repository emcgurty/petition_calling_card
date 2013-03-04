class UsersController < ApplicationController

  def logout
    @current_user = nil
    session[:user_id] = nil
    redirect_to root_url
    
  end

  def show
    if request.post?
      @current_user = Users.find(:first, :conditions=>['username = ?', params[:users][:username]])
      if @current_user
        if @current_user.activation_code.blank? && @current_user.authenticated?(params[:users][:password])
          session[:user_id] = @current_user.user_id
          flash[:notice] = "Welcome #{@current_user.first_name} #{@current_user.last_name} "
          redirect_to root_url
        else
          flash[:notice] = "#{@current_user.first_name} #{@current_user.last_name}, please check your email to activate your login. "
          redirect_to root_url
        end
      end
    else
      @user = Users.new
    end
  end


  def update_user_information
    @users = Users.find(:first, :conditions=>['user_id = ?', session[:user_id]]) if session[:user_id]
    if @user.blank?
      #  TODO: Put redirecting code here
    end
  end

  def update
    begin
      @users = Users.find(:first, :conditions=>['user_id = ?', session[:user_id]])
      @users.update_attributes(params[:users])
    rescue Exception => msg
      render :show
    else
      @current_user = @users
      flash[:notice] = "Updates successful #{@current_user.first_name} #{@current_user.last_name} "
      redirect_to root_url
    end
  end

  def new
    @users = Users.new
  end

  def create
    # protects against session fixation attacks, wreaks havoc with
    # request forgery protection.
    # uncomment at your own risk
    reset_session
    # Must use mass assignment because of attr_accessor
    @users = Users.new(:username =>params[:users][:username],
      :first_name=>params[:users][:first_name],
      :last_name=>params[:users][:last_name],
      :email=>params[:users][:email],
      :password=>params[:users][:password],
      :password_confirmation=>params[:users][:password_confirmation],
      :remote_ip=>params[:users][:remote_ip])
    if @users.save && @users.errors.empty?
      flash[:notice] = "Thanks for signing up! Please check your email to activate your account."
      redirect_to root_url
    else
      render :action => 'new'
    end
  end

  def activate
    @current_user = params[:activation_code].blank? ? false : Users.find_by_activation_code(params[:activation_code])
    if !@current_user.activation_code.blank?
      @current_user.activate
      session[:user_id] = @current_user.user_id
      flash[:notice] = "#{@current_user.first_name} #{@current_user.last_name} your signup is complete, and you are now logged in."
    end
    redirect_to root_url
  end

  def forgot_password
    if request.post?
      forgot('password')
    else
      @users = Users.new
    end
  end

  def forgot_username
    if request.post?
      forgot('username')
    else
      @users = Users.new
    end
  end

  def forgot(which)
    if request.post?
      @users = Users.find(:first, :conditions => ['email = ?', params[:users][:email]])
      respond_to do |format|
        if !(@users.blank?)
          @users.create_reset_code(which)
          if which == 'username'
            flash[:notice] = "Path to retrieve username sent to #{@users.email}"
          else
            flash[:notice] = "Path to reset password code sent to #{@users.email}"
          end
          format.html { redirect_to root_url }
          #format.xml { render :xml => @users.email, :status => :created }
        else
          flash[:error] = "#{params[:users][:email]} does not exist in system"
          format.html { redirect_to root_url }
          #format.xml { render :xml => @users.email, :status => :unprocessable_entity }
        end
      end
    end
  end

  def reset_password
    @users = Users.find_by_reset_code(params[:id]) unless params[:id].nil?
    if request.post?
      if @users.update_attributes(:password => params[:users][:password], :password_confirmation => params[:users][:password_confirmation])
        @users.delete_reset_code
        flash[:notice] = "Password reset successfully for #{@users.email}. Please login"
        redirect_to root_url
      else
        render :action => :reset
      end
    end
  end

  def get_username
    @users = Users.find_by_reset_code(params[:id]) unless params[:id].nil?
    if @users
      @users.delete_reset_code
      flash[:notice] = "Your username is #{@users.username}. Please login."
      redirect_to root_url
    else
      flash[:notice] = "Your username was previously reported to you. Please try to login again."
      redirect_to root_url
    end
       
  end

end