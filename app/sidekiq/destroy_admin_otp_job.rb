# app/workers/destroy_admin_otp_job.rb
class DestroyAdminOtpJob
  include Sidekiq::Worker

  def perform(admin_id)
    admin = Admin.find(admin_id)
    admin.update_attribute(:otp, 11)
  end
end
