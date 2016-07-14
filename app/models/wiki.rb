class Wiki < ActiveRecord::Base
  belongs_to :user

  def private?
    private == true
  end

  def public?
    private == false
  end
end
