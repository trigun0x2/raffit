class ItemsController < ApplicationController
	before_filter :require_login
  def new
    @item = Item.new
  end

  def create
    upload = params[:upload]
    @item = Item.new(params[:item])
    if @item.save

        # insert all applicable images into db
        i = 1
        until upload["img#{i}"].nil? do
          Photo.upload(@item.id, upload["img#{i}"])
          i += 1
        end
        #

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
  end

  def list
  	@items = Item.paginate(:page => params[:page], :per_page => 10)
  end

  def buyticket
    @ticket = Ticket.new
  end

  def random_num
    sum = ActiveRecord::Base.connection.execute("SELECT COUNT(*) FROM tickets WHERE item_id='" + params[:id] + "'")
    random = rand(sum[0][0])
    win = ActiveRecord::Base.connection.execute("SELECT id FROM tickets WHERE item_id='" + params[:id] + "' LIMIT 1 OFFSET " + random.to_s)
    return win[0][0]
  end
  helper_method :random_num

end
