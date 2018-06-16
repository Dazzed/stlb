class CookieWorker
  include Sidekiq::Worker
  sidekiq_options retry: false
  def perform(id)
    sleep 10
    cookie = Cookie.find(id)
    cookie.ready = true
    cookie.save!
  end
end
