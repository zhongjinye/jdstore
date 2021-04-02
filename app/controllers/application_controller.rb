class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

  def require_is_admin
    if !current_user.admin?
      flash[:alert] = 'You are not admin'
      redirect_to root_path
    end
  end

  helper_method :current_cart

  def current_cart
    @current_cart ||= find_cart #如果有，就使用本来的current_cart，否则，find_cart
  end

  private

  def find_cart
    cart = Cart.find_by(id: session[:cart_id])
    if cart.blank? #如果cart为（blank）空
      cart = Cart.create
    end
    session[:cart_id] = cart.id   #session定义一个cart_id 指派到cart
    return cart
  end

end
