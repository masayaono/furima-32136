class PurchasesController < ApplicationController
  before_action :authenticate_user!, only: [:index, :create]
  before_action :set_item, only: [:index, :create]
  def index
    if @item.purchase.present?
      redirect_to items_path
    elsif current_user.id != @item.user_id
      @item_purchase = ItemPurchase.new
    else
      redirect_to items_path
    end
  end

  def create
    @item_purchase = ItemPurchase.new(purchase_params)
    if @item_purchase.valid?
      pay_item
      @item_purchase.save
      redirect_to items_path
    else
      render action: :index
    end
  end

  private

  def purchase_params
    params.require(:item_purchase).permit(:post_code, :prefecture_id, :city, :house_number, :building_name, :phone_number).merge(
      user_id: current_user.id, item_id: item.id, token: params[:token]
    )
  end

  def pay_item
    Payjp.api_key = ENV['PAYJP_SECRET_KEY']
    Payjp::Charge.create(
      amount: @item.price,
      card: purchase_params[:token],
      currency: 'jpy'
    )
  end

  def set_item
    @item = Item.find(params[:item_id])
  end
end
