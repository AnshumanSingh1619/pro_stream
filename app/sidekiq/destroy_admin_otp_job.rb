class DestroyAdminOtpJob
  include Sidekiq::Worker

  def perform(admin_id)
    admin = Admin.find_by(id: admin_id)
    
    if admin.otp == 0
      admin.update(otp: 11)
    end
  end
end
