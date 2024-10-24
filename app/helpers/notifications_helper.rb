module NotificationsHelper
  def notification_message(notification)
    case notification.notifiable_type
    when "Favorite"
      "#{notification.notifiable.user.name}さんが#{notification.notifiable.pet.name}にいいねしました"
    else
      "#{notification.notifiable.user.name}さんが#{notification.notifiable.pet.name}にコメントしました"
    end
  end
end
