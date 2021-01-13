class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  has_one :merchant
  has_one :customer
  # validates_presence_of :last_name, :first_name


  enum role: [:customer, :merchant, :admin]
end
