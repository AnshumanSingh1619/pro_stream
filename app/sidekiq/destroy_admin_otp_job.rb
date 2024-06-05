class DestroyAdminOtpJob
  include Sidekiq::Worker

  def perform(admin_id)
    admin = Admin.find_by(id: admin_id)
    return unless admin 

    if admin.otp == 0
      admin.update(otp: 11)
    end
  end
end
