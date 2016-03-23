class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable
  has_many :students
  has_many :subjects
  has_many :terms
  has_many :reports
  has_many :markpercents
  has_many :levels
end
