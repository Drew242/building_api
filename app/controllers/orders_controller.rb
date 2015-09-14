class OrdersController < ApplicationController
  respond_to :html, :json, :xml

  def index
    @orders = Order.all

    respond_with @orders
  end

  def show
    @order = Order.find(params[:id])

    respond_with @order
  end

  def new
    @order = Order.new
  end

  def create
    @order = Order.new(order_params)

    if @order.save
      respond_to  do |format|
        format.html { redirect_to orders_path, notice: "The order was created." }
        format.json { render json: @order }
        format.xml { render xml: @order }
      end
    else
      respond_to do |format|
        format.html do
          flash.now[:notice] = "The order was not created."
          render :new
        end
        format.json { render json: @order.errors.full_messages }
        format.xml { render xml: @order.errors.full_messages }
      end
    end
  end

  def edit
    @order = Order.find_by(id: params[:id])
  end

  def update
    @order = Order.find(params[:id])

    if @order.update_attributes(order_params)
      redirect_to order_path(@order), notice: "The order was updated."
    else
      flash.now[:notice] = "The order was not updated."
      render :edit
    end
  end

  private

  def order_params
    params.require(:order).permit(:amount)
  end
end
