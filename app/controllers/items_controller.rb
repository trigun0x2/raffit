class ItemsController < ApplicationController
	before_filter :require_login
  def new
    @item = Item.new
  end

  def create
    upload = params[:upload]
    @item = Item.new(params[:item])
    @item['user_id'] = current_user.id
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
    @photos = Photo.getByID(@item.id)
    @seller = User.find(@item.user_id).email
  end

  def list
  	@items = Item.where(:winning_ticket => nil).paginate(:page => params[:page], :per_page => 10)
  end

  def buyticket
    @ticket = Ticket.new(user_id: current_user.id, item_id: params[:id])
    @user = User.find(current_user.id)
    @item = Item.find(params[:id]) 

    if @user.credits < @item.price
      page.call :confirm, "asldfjkad"
      respond_to do |format|
            format.html { redirect_to @item, :notice => "Not enough credits!"}
      end
      redirect_to @item, :notice => "Not enough credits!"
    else
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

  def random_num(id)
    test = Item.find(id)#find()ActiveRecord::Base.connection.execute("SELECT winning_ticket FROM items WHERE id='" + params[:id] + "'")
    if (test.winning_ticket != nil)
      return User.find(Ticket.find(test.winning_ticket).user_id).email
    else
      sum = Ticket.where(:item_id => id).count#ActiveRecord::Base.connection.execute("SELECT COUNT(*) FROM tickets WHERE item_id='" + params[:id] + "'")
      if sum == 0
        return "No ticket bought!" #koans this shit
      else
        random = rand(sum)
        win = Ticket.limit(1).offset(random).where(:item_id => id)[0].id#ActiveRecord::Base.connection.execute("SELECT id FROM tickets WHERE item_id='" + params[:id] + "' LIMIT 1 OFFSET " + random.to_s)
        c1 = Item.find(id)#ActiveRecord::Base.connection.execute("UPDATE items SET winning_ticket=" + win[0][0].to_s + " WHERE id=" + params[:id])
        c1.winning_ticket = win
        c1.save
        UserMailer.winner(User.find(Ticket.find(win).user_id).email).deliver
        return User.find(Ticket.find(win).user_id).email
      end
    end
  end

  def random_num1
    id=params[:id]
    test = Item.find(id)#find()ActiveRecord::Base.connection.execute("SELECT winning_ticket FROM items WHERE id='" + params[:id] + "'")
    if (test.winning_ticket != nil)
      return test.winning_ticket
    else
      sum = Ticket.where(:item_id => id).count#ActiveRecord::Base.connection.execute("SELECT COUNT(*) FROM tickets WHERE item_id='" + params[:id] + "'")
      if sum == 0
        return nil #koans this shit
      else
        random = rand(sum)
        win = Ticket.limit(1).offset(random).where(:item_id => id)[0].id#ActiveRecord::Base.connection.execute("SELECT id FROM tickets WHERE item_id='" + params[:id] + "' LIMIT 1 OFFSET " + random.to_s)
        c1 = Item.find(id)#ActiveRecord::Base.connection.execute("UPDATE items SET winning_ticket=" + win[0][0].to_s + " WHERE id=" + params[:id])
        c1.winning_ticket = win
        c1.save
        return win
      end
    end
  end

  def givemoney
    user = current_user
    @item = Item.find(params[:id]) 
    user.credits = 10000
    user.save
    return user
  end
  
  helper_method :random_num

end
