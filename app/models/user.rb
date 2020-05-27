class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  
  validates :nickname, presence: true
  validates :email, presence: true, uniqueness: true, format: {with:  /\A[a-zA-Z0-9_#!$%&`'*+-{|}~^\/=?.]+@[a-zA-Z0-9][a-zA-Z0-9.-]+\z/}
  validates :password,  length: { minimum: 7 }, format: {with: /\A(?=.*?[a-z])(?=.*?\d)[a-z\d]{7,}\Z/i}
  has_one   :person_info, dependent: :destroy, inverse_of: :user
  has_one   :address,     dependent: :destroy
end
