namespace :user do
  desc "Create admin account"
  task create_admins: :environment do
    User.create(
      [
        {
          name: "Trinh Duc Duy",
          email: "trinh.duc.duy@framgia.com",
          password: "12345678",
          password_confirmation: "12345678",
          role: User.roles[:admin]
        },
        {
          name: "Luong Viet Dung",
          email: "luong.viet.dung@framgia.com",
          password: "12345678",
          password_confirmation: "12345678",
          role: User.roles[:admin]
        }
      ])
  end
end
