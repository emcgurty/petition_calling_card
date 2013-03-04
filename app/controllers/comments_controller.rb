class CommentsController < ApplicationController

  def new
    @comments = Comments.new(:p_uuid => params[:id])
  end

  def list
    @comments = Comments.find(:all, :readonly => true, :conditions => ['p_uuid = ?',params[:id]] )
    respond_to do |format|
      format.html
    end
    
  end

   
  def delete
    if Comments.find(params[:id]).destroy
      flash[:notice] = 'Comment successfully deleted'
      redirect_to perspectives_show_url
    end

  end

  def create
    @comments = Comments.new(
      :p_uuid => params[:p_uuid].to_s,
      :remote_ip => params[:remote_ip].to_s,
      :record_text   => params[:comments][:record_text],
      :alias      => params[:comments][:alias],
      :email      => params[:comments][:email]
    )
    if @comments.save
      flash[:notice] = 'Message successfully sent to '  + params[:comments][:email] + '.'
      redirect_to :controller=>'home', :action=>'show', :id=>'emailsuccess'
    else
      flash[:notice] = 'Message not successfully sent to '  + params[:comments][:email] + '.'
      redirect_to :controller=>'home', :action=>'show', :id=>'emailsuccess'
    end

  end

end
