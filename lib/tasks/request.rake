namespace :request do
  desc "Delete request resolved"
  task delete_requests_resolved: :environment do
    Request.delete_all status: Request.statuses[:resolved]
  end
end
