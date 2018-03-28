class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable


  has_many :user_person_joins
  has_many :people, through: :user_person_joins
  has_many :user_location_joins
  has_many :locations, through: :user_location_joins
end
