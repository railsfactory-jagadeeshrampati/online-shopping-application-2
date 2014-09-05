class OrdersController < ApplicationController
  before_action :authenticate_user!
  #include CurrentCart
  skip_before_action :authorize, only: [:new, :create]
  #before_action :set_cart, only: [:new, :create]
  before_action :set_order, only: [:show, :edit, :update, :destroy]
  before_filter :check_privileges!, only: [:index]

  # GET /orders
  # GET /orders.json
  def index
    @orders = Order.where(user_id: current_user.id)
  end

  # GET /orders/1
  # GET /orders/1.json
  def show
    redirect_to store_url 
  end

  # GET /orders/new
  def new
    if current_user.line_items.where(order_id: nil).empty?
     redirect_to store_url, notice: "Your cart is empty"
    else
    @order = Order.new
    end
  end

  # GET /orders/1/edit
  def edit
  end

  # POST /orders
  # POST /orders.json
  def create
    @order = Order.new(order_params)
    #current_user.line_items.order_id = @order.id
    @order.user_id = current_user.id
 

    respond_to do |format|
      if @order.save
           current_user.line_items.where(:order_id => nil).update_all(:order_id => @order.id)
         # current_user.line_items.added_to_cart.update_attributes(ordered: true).where(@order.user_id = current_user.id)
        
        OrderNotifier.received(@order).deliver

        format.html { redirect_to store_url, notice: I18n.t('.thanks') }
        format.json { render :show, status: :created, location: @order }
      else
        format.html { render :new }
        format.json { render json: @order.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /orders/1
  # PATCH/PUT /orders/1.json
  def update
    respond_to do |format|
      if @order.update(order_params)
        format.html { redirect_to @order, notice: 'Order was successfully updated.' }
        format.json { render :show, status: :ok, location: @order }
      else
        format.html { render :edit }
        format.json { render json: @order.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /orders/1
  # DELETE /orders/1.json
  def destroy
    @order.destroy
    respond_to do |format|
      format.html { redirect_to orders_url, notice: 'Order was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_order
      @order = Order.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def order_params
      params.require(:order).permit(:name, :address, :email, :pay_type)
    end
end
