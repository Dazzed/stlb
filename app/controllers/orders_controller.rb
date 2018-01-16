class OrdersController < ApiController
  def index
    @orders = Order.all
  end

  def fulfill
    @order = Order.find(params[:id])
    @order.fulfilled = true
    @order.save!
  end
end
