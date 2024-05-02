module MyListsHelper
  def newcontents
    @contents.where(:created_at.gte => 2.days.ago)
  end

  def mylisth
    MyList.where(content_id: @content.id, semi_user_id: session[:current_semi_user_id]["value"])
  end
  
end

