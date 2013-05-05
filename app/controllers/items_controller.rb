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
        unless upload.nil?
          i = 1
          until upload["img#{i}"].nil? do
            Photo.upload(@item.id, upload["img#{i}"])
            i += 1
          end
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

  def random_num
    test = ActiveRecord::Base.connection.execute("SELECT winning_ticket FROM items WHERE id='" + params[:id] + "'")
    if (test[0][0] != nil)
      return test[0][0]
    else
      sum = ActiveRecord::Base.connection.execute("SELECT COUNT(*) FROM tickets WHERE item_id='" + params[:id] + "'")
      random = rand(sum[0][0])
      win = ActiveRecord::Base.connection.execute("SELECT id FROM tickets WHERE item_id='" + params[:id] + "' LIMIT 1 OFFSET " + random.to_s)
      ActiveRecord::Base.connection.execute("UPDATE items SET winning_ticket=" + win[0][0].to_s + " WHERE id=" + params[:id])
      return win[0][0]
    end
  end
  
  helper_method :random_num

end
