class ItemsController < ApplicationController
	before_filter :require_login
  def new
    @item = Item.new
  end

  def create
    @item = Item.new(params[:item])
    if @item.save
      	respond_to do |format|
  		    format.html { redirect_to @item }
  		    format.js
  		  end
    else
      render :new
    end
  end

  def show
  	@item = Item.find(params[:id])  
    @ticket = Ticket.find_all_by_user_id(current_user.id, :conditions => [ "item_id = ?", @item.id])
  end

  def list
  	@items = Item.paginate(:page => params[:page], :per_page => 10)
  end

  def buyticket
    @ticket = Ticket.new(user_id: current_user.id, item_id: params[:id])
    @item = Item.find(params[:id]) 
    if @ticket.save
        respond_to do |format|
          format.html { redirect_to @item }
          format.js
        end
    else
      render :buyticket
    end

  end

end
