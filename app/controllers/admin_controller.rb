class AdminController < ApplicationController

  def create
    @cut = 0
    if params[:record_cut]
      if params[:record_cut] == 'approved'
        @cut = 1
      end
    end

    if params[:commit] == "Submit Perspectives Approvals"
      update_approvals('p')
      redirect_to :action => 'tables_to_approve'
    elsif params[:commit] == "Submit Linkrequests Approvals"
      update_approvals('l')
      redirect_to :action => 'tables_to_approve'
    elsif params[:commit] == "Submit Comments Approvals"
      update_approvals('c')
      redirect_to :action => 'tables_to_approve'
    elsif params[:commit] == "Approve Selected Table"
      if params[:approve] == 'perspectives'
        redirect_to :action => 'tables_to_approve', :p => true, :record_cut => @cut
      elsif params[:approve] == 'comments'
        redirect_to :action => 'tables_to_approve', :c => true, :record_cut => @cut
      elsif params[:approve] == 'linkrequests'
        redirect_to :action => 'tables_to_approve', :l => true, :record_cut => @cut
      end
    end
  end

  def tables_to_approve
  end

  private

  def update_approvals(table)
    @count_of_records = params[:count].to_i
    @counter = 0
    @count_of_records.times do
      @counter = @counter + 1
      if table == 'p'
        @tmp = Perspectives.find(params["id_#{@counter}"])
      elsif table == 'c'
        @tmp = Comments.find(params["id_#{@counter}"])
      elsif table == 'l'
        @tmp = Linkrequests.find(params["id_#{@counter}"])
      end
      if params["approved_#{@counter}"]
        @a_value = true
      else
        @a_value = false
      end
      @tmp.update_attributes(:record_text => params["text_#{@counter}"], :approved => @a_value )
      
    end
  end

end
