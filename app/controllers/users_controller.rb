class UsersController < ApplicationController

  def show
    @stripe_btn_data = {
      key: "#{ Rails.configuration.stripe[:publishable_key] }",
      description: "Philipedia Inc. - #{current_user.email}",
      amount: Amount.default
    }
  end

  def downgrade_account
    current_user.downgrade_role
    current_user.wikis.where(private: true).update_all(private: false)
    redirect_to users_show_path
  end
end
