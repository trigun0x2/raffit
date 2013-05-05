class ItemsController < ApplicationController
  def new
    @item = Item.new
  end

  def create
    @item = Item.new(params[:item])
    if @item.save
      	respond_to do |format|
		    format.html { redirect_to item_url }
		    format.js
  		end

    else
      render :new
    end
  end
end
