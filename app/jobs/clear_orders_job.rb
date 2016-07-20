class ClearOrdersJob < ApplicationJob
  queue_as :default

  def perform
    Order.temporary.destroy_all
  end
end
