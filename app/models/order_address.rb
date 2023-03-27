class OrderAddress
  include ActiveModel::Model
  attr_accessor :post_code, :prefecture_id, :delivery_city, :delivery_address, :delivery_building, :telephone_number,
                :user_id, :token, :item_id

  with_options presence: true do
    # (with_options format: { with: /\A[0-9]+\z/ } do
    #   validates :price, numericality: { only_integer: true, greater_than_or_equal_to: 300, less_than_or_equal_to: 9_999_999 },
    #                     presence: { message: "can't be blank" }
    # end)
    validates :user_id
    validates :post_code, format: { with: /\A[0-9]{3}-[0-9]{4}\z/, message: 'is invalid. Include hyphen(-)' }
    validates :telephone_number, format: { with: /\A[0-9]+\z/ }
  end
  validates :prefecture_id, numericality: { other_than: 1, message: "can't be blank" }
  validates :token, presence: true

  def save
    # 寄付情報を保存し、変数donationに代入する
    order = Order.create!(user_id: user_id, item_id: item_id)
    # 住所を保存する
    # donation_idには、変数donationのidと指定する
    Address.create!(post_code: post_code, prefecture_id: prefecture_id, delivery_city: delivery_city,
                   delivery_address: delivery_address, delivery_building: delivery_building, telephone_number: telephone_number, order_id: order.id)
  end
end
