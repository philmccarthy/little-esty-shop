class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  has_one :merchant, dependent: :destroy
  has_one :customer, dependent: :destroy
  has_many :chat_rooms, dependent: :destroy
  has_many :messages, dependent: :destroy
  # validates_presence_of :last_name, :first_name

  def name
    first_name + " " + last_name
  end
  
  enum role: [:customer, :merchant, :admin]
end
