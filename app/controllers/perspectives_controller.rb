class PerspectivesController < ApplicationController

  #  before_filter :user_delete,  :only=>[:delete]
  # cache_sweeper :perspectives_sweeper

  def approved
    puts 'Liz'
    puts 'liz2'
  end

  def new
    @perspectives = Perspectives.new
  end

  def create
    do_create
  end

  def delete_confirm
    @perspectives = Perspectives.find(params[:id], :readonly => true)
  end

  def show
    do_show
  end

  def options
	end

  def confirm
    @perspectives = Perspective.find(params[:id], :readonly => true)
  end
  
  def destroy
    do_destroy
  end

  def accept
    do_accept
  end

  private

  def do_accept
    @myid = Perspectives.find(params[:id])
  end

  def do_create
    @perspectives = Perspectives.new(
      :remote_ip => params[:perspectives][:remote_ip],
      :record_text     => params[:perspectives][:record_text],
      :alias      => params[:perspectives][:alias],
      :email      => params[:perspectives][:email]
    )
    if @perspectives.save
      flash[:notice] = 'Message successfully sent to '  + params[:perspectives][:email] + '.'
      redirect_to :controller=>'home', :action=>'show', :id=>'emailsuccess'
    else
      flash[:notice] = 'Message not successfully sent to '  + params[:perspectives][:email] + '.'
      redirect_to :controller=>'home', :action=>'show', :id=>'emailsuccess'
    end
  end


  def do_show
    begin
      @perspectives = Perspectives.find(:all, :readonly=> true, :conditions => "approved = 1" )
    rescue
      error_msg = "Invalid statement discovered in Listing Perspectives."
      redirect_to :controller=>'home', :action => 'error_page', :error_msg => error_msg
    end

  end

  def do_destroy
    begin
      @myid = Perspectives.find(params[:id])
      @instAlias = Perspectives.find(params[:id]).alias
      Perspectives.find(params[:id], :conditions=> ['alias = ?', @instAlias]).destroy
      redirect_to root_url

    rescue ActiveRecord::RecordNotFound
      @error_msg = "Record not found in 'Changed My Mind' perspectives function"
      redirect_to :controller=>'home', :action=>'error_page', :error_msg => @error_msg
    rescue ActiveRecord::ActiveRecordError => msg
      @error_msg = "Active Record Error in 'Changed My Mind' perspectives function"
      redirect_to :controller=>'home', :action=>'error_page', :error_msg => msg
    end
  end
  
end
