class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable, :confirmable

  has_many :wikis, dependent: :destroy
  after_initialize :default_role

  def standard?
    user.role == 'standard'
  end

  def premium?
    user.role == 'premium'
  end

  def admin?
    user.role == 'admin'
  end

  private
  def default_role
    self.role ||= 'standard'
  end
end
