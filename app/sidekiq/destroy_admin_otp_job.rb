class DestroyAdminOtpJob
  include Sidekiq::Worker
  include Sidekiq::Benchmark::Worker

  def perform(admin_id)
    admin = Admin.find_by(id: admin_id)

    unless admin.otp == "0"
      admin.update(otp: 11)
    end
  end
end
