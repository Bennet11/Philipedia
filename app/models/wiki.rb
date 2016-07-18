class Wiki < ActiveRecord::Base

  belongs_to :user

  has_many :collaborations
  has_many :users, through: :collaborations

  
  def private?
    private == true
  end

  def public?
    private == false
  end
end
