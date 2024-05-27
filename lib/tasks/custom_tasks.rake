# lib/tasks/user_tasks.rake
namespace :custom do
  desc "Send content to user"
  task send_content_user: :environment do
    users = User.all
    users.each do |user|
      UserMailer.send_content(user.email).deliver_now
    end
  end
end
