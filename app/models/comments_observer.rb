class CommentsObserver < ActiveRecord::Observer

  observe :comments

  def before_create(comments)
    comments.c_uuid = UUIDTools::UUID.timestamp_create().to_s
  end

end
