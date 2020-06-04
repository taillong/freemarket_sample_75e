class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  
  has_one :card, dependent: :destroy
  has_one :address, dependent: :destroy
  has_one :person_info, dependent: :destroy
  has_many :sell_items, class_name: 'Item', foreign_key: 'seller_id',dependent: :destroy
  has_many :buy_items, class_name: 'Item', foreign_key: 'buyer_id'
  has_many :cards

  
  validates :nickname, presence: true
  validates :email, uniqueness: true, format: {with:  /\A[a-zA-Z0-9_#!$%&`'*+-{|}~^\/=?.]+@[a-zA-Z0-9][a-zA-Z0-9.-]+\z/}
  validates :password, format: {with: /\A(?=.*?[a-z])(?=.*?\d)[a-z\d]{7,}\Z/}
  has_one   :person_info, dependent: :destroy
  has_one   :address,     dependent: :destroy
end
