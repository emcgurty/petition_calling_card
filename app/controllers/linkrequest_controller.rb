class LinkrequestController < ApplicationController

  def sendemail
    # TODO
  end


  def update
    do_update
  end

  def edit
    unless @linkrequest
      @linkrequest= Linkrequest.find(:first, :conditions => ['id = ?', params[:id].blank? ? params[:linkrequest][:id] : params[:id] ])
    end
    session[:resource_rows] = @linkrequest.offerings.count
    if session[:resource_rows] == 0
      session[:resource_rows] = 1
    end
    respond_to do |format|
      format.html
    end
  end

  def displayalllistingsgrid
    @linkrequest = Linkrequest.find(:all, :readonly=>true)
    respond_to do |format|
      format.html
    end
  end

  def destroy
    destroy_this
  end

  def new
    unless @linkrequest
      session[:resource_rows] = CollaboratorMethods.collaborator_value[:display_resources][:number].to_i
      session[:remaining_resource_rows] = CollaboratorMethods.collaborator_value[:display_resources][:max].to_i
      @linkrequest = Linkrequest.new
    end
  end

  def create
    if params[:commit]  == "Add New Resource"
      do_add_new_resource
    elsif params[:commit] == "Changed My Mind"
      unless params[:linkrequest][:id].blank?
        destroy_this
      else
        flash[:notice] = "Prehaps later you will offer your link."
        redirect_to root_url
      end
    elsif params[:commit]  == "Submit Updates for Approval"
      update
    else
      do_create
    end
    
  end

  private

  def do_update
    
    if session[:user_id]
      u_id = session[:user_id]
    else
      u_id = ''
    end
    @link_updated = false
    @offering_updated = false

    @linkrequest =  Linkrequest.find(:first, :conditions=>['id = ?', params[:linkrequest][:id]])
    unless @linkrequest.blank?
      @linkrequest.update_attributes(
        :organization_url => "http://" + params[:linkrequest][:organization_url],
        :email => params[:linkrequest][:email],
        :record_text => params[:linkrequest][:record_text],
        :organization_name => params[:linkrequest][:organization_name],
        :first_name => params[:linkrequest][:first_name],
        :mi => params[:linkrequest][:mi],
        :last_name => params[:linkrequest][:last_name],
        :city => params[:linkrequest][:city],
        :country_id => params[:countries],
        :state_id => params[:us_states],
        :zip_code => params[:linkrequest][:zip_code],
        :remote_ip => params[:linkrequest][:remote_ip],
        :uploaded_picture => params[:linkrequest][:uploaded_picture],
        :user_id => u_id)
    else
      ## TODO Clean this up, make it more informative
      return
     
    end

    @hold_save_result = @linkrequest.save()
    @hold_save_result.blank? ? @link_updated = false : @link_updated = true
    @ct = 0
    @does_support = false
    Offering.destroy_all(:linkrequest_id => @linkrequest.id )
    session[:resource_rows].times do
      unless params["deo_#{@ct}"].to_i == 1
        if params["so_#{@ct}"].to_i == 1
          @does_support = true
        else
          @does_support = false
        end
        unless @hold_save_result.blank?
          @offer = @linkrequest.offerings.create(:resource_url => params["ru_#{@ct}"], :resource_description => params["rd_#{@ct}"], :supporting => @does_support)
        else
          @offer = @linkrequest.offerings.build(:resource_url => params["ru_#{@ct}"], :resource_description => params["rd_#{@ct}"], :supporting => @does_support)
        end
        
        @ct = @ct + 1
      end
    end
    unless @hold_save_result.blank?
      if @offering_updated && @link_updated
        flash[:notice] = "Your link information with offered resources has been updated."
        redirect_to root_url
      elsif !(@offering_updated) &&  @link_updated
        flash[:notice] = "Your link information has been updated."
        redirect_to root_url
      end
    else
      render :action => :edit
    end
  end

  def destroy_this

    unless params[:id].blank?
      @lid = Linkrequest.find(params[:id])
    else
      @lid = Linkrequest.find(params[:linkrequest][:id])
    end
    ## Tying a delete to an existing other column, eg, organization_name.  Just to make the delete more rigorous, eg, url tampering
    @org = @lid.organization_name
    begin
      if @org
        Linkrequest.destroy_all(:id => @lid.id)
        ## Shouldn't be necessary if dependent => destroy in linkrequest.rb works
        Offering.destroy_all(:linkrequest_id => @lid.id)
      else
        ## TODO
      end

    rescue ActiveRecord::RecordNotFound
      error_msg = "Record not found in 'Changed My Mind' link request function"
      redirect_to :controller=>'home', :action=>'error_page', :error_msg => error_msg
    rescue ActiveRecord::ActiveRecordError
      error_msg = "Active Record Error in 'Changed My Mind' link request function"
      redirect_to :controller=>'home', :action=>'error_page', :error_msg => error_msg
    else
      if params[:commit] == "Changed My Mind"
        flash[:notice] = "#{@org} record was not saved to the database."
        redirect_to root_url
      else
        flash[:notice] = "#{@org}, your offered link has been deleted."
        redirect_to root_url
      end
    end

  end

  def do_add_new_resource

    session[:user_id] ? u_id = session[:user_id] : u_id = ''
    
    unless params[:linkrequest][:id].blank?
      @linkrequest = Linkrequest.find(params[:linkrequest][:id])
      @linkrequest.update_attributes(
        :organization_url => params[:linkrequest][:organization_url],
        :email => params[:linkrequest][:email],
        :record_text => params[:linkrequest][:record_text],
        :organization_name => params[:linkrequest][:organization_name],
        :first_name => params[:linkrequest][:first_name],
        :mi => params[:linkrequest][:mi],
        :last_name => params[:linkrequest][:last_name],
        :city => params[:linkrequest][:city],
        :country_id => params[:countries],
        :state_id => params[:us_states],
        :zip_code => params[:linkrequest][:zip_code],
        :remote_ip => params[:linkrequest][:remote_ip],
        :uploaded_picture => params[:linkrequest][:uploaded_picture],
        :user_id => u_id,
        :approved => 0)
    else
      @linkrequest = Linkrequest.new(
        :organization_url => params[:linkrequest][:organization_url],
        :email => params[:linkrequest][:email],
        :record_text => params[:linkrequest][:record_text],
        :organization_name => params[:linkrequest][:organization_name],
        :first_name => params[:linkrequest][:first_name],
        :mi => params[:linkrequest][:mi],
        :last_name => params[:linkrequest][:last_name],
        :city => params[:linkrequest][:city],
        :country_id => params[:countries],
        :state_id => params[:us_states],
        :zip_code => params[:linkrequest][:zip_code],
        :remote_ip => params[:linkrequest][:remote_ip],
        :uploaded_picture => params[:linkrequest][:uploaded_picture],
        :user_id => u_id,
        :approved => 0)
    end
    ## Don't want to perform validation on adding a row
    @linkrequest.save(:validate => false)
    @ct = 0
        
    Offering.destroy_all(:linkrequest_id => @linkrequest.id )
    session[:resource_rows].times do
      if params["so_#{@ct}"].to_i == 1
        @does_support = true
      else
        @does_support = false
      end
      if @linkrequest.id.blank?
        @linkrequest.offerings.build(:resource_url => params["ru_#{@ct}"], :resource_description => params["rd_#{@ct}"], :supporting => @does_support)
      else
        @linkrequest.offerings.create(:resource_url => params["ru_#{@ct}"], :resource_description => params["rd_#{@ct}"], :supporting => @does_support)
      end

      @ct = @ct + 1
    end
    session[:resource_rows] = session[:resource_rows] + 1
    session[:remaining_resource_rows] = CollaboratorMethods.collaborator_value[:display_resources][:max].to_i - session[:resource_rows]
    if session[:remaining_resource_rows].to_i == 0
      flash[:notice] = "Sorry, no more remaining resource rows."
    else
      flash[:notice] = "You can add #{session[:remaining_resource_rows]} more resources rows."
    end
    # a blank offering record
    @linkrequest.offerings.create()
    render :action => :new

  end


  def do_create

    session[:user_id] ? u_id = session[:user_id] : u_id = ''
    
    # TODO Manage result with flash messaging
    @link_updated = true
    @offering_updated = false

    unless params[:linkrequest][:id].blank?
      @linkrequest = Linkrequest.find(params[:linkrequest][:id])
      @linkrequest.update_attributes(
        :organization_url => params[:linkrequest][:organization_url],
        :email => params[:linkrequest][:email],
        :record_text => params[:linkrequest][:record_text],
        :organization_name => params[:linkrequest][:organization_name],
        :first_name => params[:linkrequest][:first_name],
        :mi => params[:linkrequest][:mi],
        :last_name => params[:linkrequest][:last_name],
        :city => params[:linkrequest][:city],
        :country_id => params[:countries],
        :state_id => params[:us_states],
        :zip_code => params[:linkrequest][:zip_code],
        :remote_ip => params[:linkrequest][:remote_ip],
        :uploaded_picture => params[:linkrequest][:uploaded_picture],
        :user_id => u_id,
        :approved => 0)
    else
      @linkrequest = Linkrequest.new(
        :organization_url => params[:linkrequest][:organization_url],
        :email => params[:linkrequest][:email],
        :record_text => params[:linkrequest][:record_text],
        :organization_name => params[:linkrequest][:organization_name],
        :first_name => params[:linkrequest][:first_name],
        :mi => params[:linkrequest][:mi],
        :last_name => params[:linkrequest][:last_name],
        :city => params[:linkrequest][:city],
        :country_id => params[:countries],
        :state_id => params[:us_states],
        :zip_code => params[:linkrequest][:zip_code],
        :remote_ip => params[:linkrequest][:remote_ip],
        :uploaded_picture => params[:linkrequest][:uploaded_picture],
        :user_id => u_id,
        :approved => 0)
    end
    @hold_saved_result = @linkrequest.save()
    @ct = 0
    ##  Pass to hold variable because session[:reources_rows] will be updated in following code
    @hold_num = session[:resource_rows]
    @hold_num.times do
        
      if params["deo_#{@ct}"] == "0"
        if params["so_#{@ct}"].to_i == 1
          @does_support = true
        else
          @does_support = false
        end
        unless  @hold_saved_result.blank?
          @linkrequest.offerings.create(:resource_url => params["ru_#{@ct}"], :resource_description => params["rd_#{@ct}"], :supporting => @does_support)
        else
          @linkrequest.offerings.build(:resource_url => params["ru_#{@ct}"], :resource_description => params["rd_#{@ct}"], :supporting => @does_support)
        end
 
      else
        session[:resource_rows] = session[:resource_rows] - 1
      end
      @ct = @ct + 1
    end
    
    unless @hold_saved_result.blank?
      flash[:notice] = "Your link offering has been saved."
      redirect_to root_url
    else
      render :action => 'new'
    end
  end
end
