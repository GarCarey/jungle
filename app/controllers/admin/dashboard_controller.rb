class Admin::DashboardController < ApplicationController
  def show
    @product_quantity = Product.count
    @category_quantity = Category.count
  end
end
