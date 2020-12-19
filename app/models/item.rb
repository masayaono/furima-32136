class Item < ApplicationRecord
  with_options presence: true do
    validates :name
    validates :introduction
    validates :category_id
    validates :item_condition_id
    validates :prefecture_id
    validates :preparation_day_id
    validates :postage_payer_id
    validates :price, format: { with: /\A[0-9]+\z/ }, numericality: { greater_than_or_equal_to: 300, less_than_or_equal_to: 9_999_999 }
    validates :image
  end

  with_options numericality: { other_than: 1 } do
    validates :category_id
    validates :item_condition_id
    validates :postage_payer_id
    validates :prefecture_id
    validates :preparation_day_id
  end
  
  extend ActiveHash::Associations::ActiveRecordExtensions
  belongs_to :category
  belongs_to :condition
  belongs_to :postage_payer
  belongs_to :prefecture
  belongs_to :preparation_day

  has_one_attached :image
  belongs_to:user
  has_one :purchase, dependent: :destroy
end