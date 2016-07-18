class WikiPolicy < ApplicationPolicy

  def update?
    user.present? && record.user == user
  end


  class Scope
    attr_reader :user, :scope

    def initialize(user, scope)
      @user = user
      @scope = scope
    end

    def resolve
      wikis = []
      if user.role == 'admin'
        wikis = scope.all
      elsif user.role == 'premium'
        all_wikis = scope.all
        all_wikis.each do |wiki|
          if wiki.public? || wiki.private? || wiki.user == user
            wikis << wiki
          end
        end
      elsif
        all_wikis = scope.all
        wikis = []
        all_wikis.each do |wiki|
          if wiki.public? 
            wikis << wiki
          end
        end
      end
      wikis
    end
  end
end
