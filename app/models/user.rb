class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  
  validates :nickname, presence: true
  validates :email, uniqueness: true, format: {with:  /\A[a-zA-Z0-9_#!$%&`'*+-{|}~^\/=?.]+@[a-zA-Z0-9][a-zA-Z0-9.-]+\z/}
  validates :password, format: {with: /\A(?=.*?[a-z])(?=.*?\d)[a-z\d]{7,}\Z/}
  has_one   :person_info, dependent: :destroy
  has_one   :address,     dependent: :destroy
end
