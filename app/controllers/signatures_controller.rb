class SignaturesController < ApplicationController

  # caches_page :show
  # expire_page :action => :show_refresh, :id => @signatures
  # cache_sweeper :signatures_sweeper
  
  def delete_display
    @signatures = Signatures.find(params[:id])
  end

 	def delete
    @tmp_signature = Signatures.find(params[:id])
    @tmp_signature.signature_number = false
    @tmp_signature.save
    redirect_to :action => 'show_refresh', :id => ''
	end


  def show_refresh
    #    expire_action :action => :show_refresh
    if (params[:id] == 'map')
      render :action=>'map'
    else
      do_show
    end
  end
  
  def new
    if @signatures.blank?
      @signatures = Signatures.new
    end
    
    respond_to do |format|
      format.html # new.html.erb
      #      format.xml  { render :xml => @signatures }
    end
  end

   
  def create                              
   
    number_hash = Hash.new
    number_hash = {'signature_number' => true}

    state_hash = Hash.new
    state_hash = {'state_id' => params['state_id']}

    country_hash = Hash.new
    country_hash = {'country_id' => params['country_id']}

    params[:signatures].merge!(state_hash)
    params[:signatures].merge!(country_hash)
    params[:signatures].merge!(number_hash)

    @signatures = Signatures.new(params[:signatures])
    unless params[:signatures][:signature_agreement] == '0'
      if @signatures.save
        flash[:notice] = 'Message successfully sent to '  + params[:signatures][:last_name] + '.'
        redirect_to show_refresh_url
      else
        flash[:notice] = 'Message not successfully sent to '  + params[:signatures][:last_name] + '.'
        redirect_to show_refresh_url
      end

    else
      flash[:notice] = "You need to check 'I attest that I am a responsible person...' in order to submit your signature."
      render :action => 'new'
    end
  end

  
  def map
    # TOTO
  end


  private

  def do_show
    # TODO Not happy with this at all.  Just wish Rails would return a record number so that I could do an offset.  
    unless params[:id].blank?
      @ct = 1
      @asd = true
      @break_out = false
      session[:start_id] = params[:id]
      @signatures = Signatures.find(:all, :readonly=>true, :order=>'created_at ASC', :conditions => ['signature_number = true'])
      @ids_array = Array.new
      @signatures.each do |sign|
        if sign.uuid == params[:id] || @asd == false
          
          if @ct < 11
            @ids_array << sign.uuid unless sign.uuid.blank?
            @ct = @ct + 1
            @asd = false
          else
            @break_out = true
          end
        end
        break if @break_out
      end
      @signatures = Signatures.find(:all, :readonly=>true, :order=>'created_at ASC', :conditions => ['uuid IN (?)', @ids_array])
    else
      @signatures = Signatures.find(:all, :readonly=>true, :order=>'created_at ASC')
      session[:start_id] = ''
    end
  end


end

