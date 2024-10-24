class Admin::OrdersController < ApplicationController
  layout "admin"

  def index
    @order_details = OrderDetail.all
  end
end
