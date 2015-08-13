every 1.month, at: "end of the month at 11:59pm" do
  rake "request:delete_requests_resolved"
end

every :day, at: "14:42" do
  rake "request:delete_requests_resolved", environment: :development
end
