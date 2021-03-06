class CartsController < ApplicationController
  include ActionView::Helpers::TextHelper

  def create
    accessory = Accessory.find(params[:accessory_id])

    @cart = Cart.new(session[:cart])
    @cart.add_accessory(accessory.id)
    session[:cart] = @cart.contents

    flash[:notice] = "You now have #{pluralize(session[:cart][accessory.id.to_s], accessory.title)} in your cart."
    redirect_to '/bike-shop'
  end

  def update
    accessory = Accessory.find(params[:accessory_id])
    @cart = Cart.new(session[:cart])
    if params[:decrease]
      if @cart.contents[accessory.id.to_s] <= 1
        delete_accessory(accessory.id.to_s)
        @cart = Cart.new(session[:cart])
      else
        @cart.decrease_accessory(accessory.id)
      end
    else
      @cart.add_accessory(accessory.id)
    end
    session[:cart] = @cart.contents
    redirect_to cart_path
  end

  def show
    cart = Cart.new(session[:cart])
    contents = cart.contents
    @cart_items = contents.keys.map do |key|
      [Accessory.find(key.to_i), contents[key]]
    end
    @total = cart.total_cost
  end

  def destroy
    delete_accessory(params[:accessory])
    redirect_to cart_path
  end

  private

  def delete_accessory(id)
    accessory = Accessory.find(id)
    session[:cart].delete(id)
    flash[:notice] = "Successfully removed #{view_context.link_to accessory.title, accessory_path(accessory)} from your cart"
  end
end
