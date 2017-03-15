module ApplicationHelper


  def author_name(obj)
    case obj
    when Comment
      post_obj = obj.post
    when Post
      post_obj = obj
    end

    if post_obj.user.present?
      post_obj.user.full_name
    else
      "Post has no Author"
    end
  end

end
