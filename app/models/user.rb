class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable, :confirmable

  has_many :wikis, dependent: :destroy
  after_initialize :default_role

  def standard?
    role == 'standard'
  end

  def premium?
    role == 'premium'
  end

  def admin?
    role == 'admin'
  end

  def upgrade_role
    self.update(role: 'premium')
  end

  def downgrade_role
    self.update(role: 'standard')
  end

  private
  def default_role
    self.role ||= 'standard'
  end
end
