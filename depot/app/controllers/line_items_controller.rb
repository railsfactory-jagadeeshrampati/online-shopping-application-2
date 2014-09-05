class LineItemsController < ApplicationController
  before_action :authenticate_user!
  #include CurrentCart
  skip_before_action :authorize, only: :create
  #before_action :set_cart, only: [:create]
  before_action :set_line_item, only: [:show, :edit, :update, :destroy]

  # GET /line_items
  # GET /line_items.json
  def index
    @line_items = LineItem.all
  end

  # GET /line_items/1
  # GET /line_items/1.json
  def show
   # @added_to_cart = current_user.line_items.added_to_cart
   @added_to_cart=current_user.line_items.where(order_id: nil)
  end

  # GET /line_items/new
  def new
    @line_item = LineItem.new
  end

  # GET /line_items/1/edit
  def edit
  end

  # POST /line_items
  # POST /line_items.json
  def create
    @product = Product.find(params[:product_id])
   # @line_item = current_user.line_items.build(product: @product)
    @line_item = @product.add_product(@product.id, current_user)
    @line_item.user_id = current_user.id
    @line_item.price = @product.price


    respond_to do |format|
      if @line_item.save
       format.html { redirect_to @line_item, notice: 'Product was added successfully.' }
       #format.js   { @current_item = @line_item }
       format.json { render :show, status: :created, location: @line_item }
      else
        format.html { render :new }
        format.json { render json: @line_item.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /line_items/1
  # PATCH/PUT /line_items/1.json
  def update
    respond_to do |format|
      if @line_item.update(line_item_params)
        format.html { redirect_to @line_item, notice: 'Line item was successfully updated.' }
        format.json { render :show, status: :ok, location: @line_item }
      else
        format.html { render :edit }
        format.json { render json: @line_item.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /line_items/1
  # DELETE /line_items/1.json
  def destroy
      current_user.line_items.where(order_id: nil).destroy_all
      respond_to do |format|
       format.html { redirect_to store_url, notice: 'cart was successfully destroyed.' }
      format.json { head :no_content }
    end
  end




  private
    # Use callbacks to share common setup or constraints between actions.
    def set_line_item
      @line_item = LineItem.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def line_item_params
      params.require(:line_item).permit(:product_id)

    end
end
