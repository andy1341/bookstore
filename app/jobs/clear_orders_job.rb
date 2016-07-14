class ClearOrdersJob < ApplicationJob
  queue_as :default

  def perform
    Order.where('user_id is NULL AND created_at < ?', 1.days.ago).destroy_all
  end
end
