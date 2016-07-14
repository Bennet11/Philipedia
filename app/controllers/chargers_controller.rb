class ChargersController < ApplicationController

  def new
    @stripe_btn_data = {
      key: "#{ Rails.configuration.stripe[:publishable_key] }",
      description: "Philipedia Inc. - #{current_user.name}",
      amount: Amount.default
    }
  end

  def create
    customer = Stripe::Customer.create(
      email: current_user.email,
      card: params[:stripeToken]
    )

    charge = Stripe::Charge.create(
      customer: customer.id,
      amount: Amount.default,
      description: "Philipedia Inc. - #{current_user.email}",
      currency: 'usd'
    )

    if charge.paid == true
      current_user.upgrade_account
      flash[:notice] = "Thank you for Upgrading to Premium. Enjoy all the privileges of a Premium User."
      redirect_to ##############################
    end

    rescue Stripe::CardError => e
      flash[:alert] = e.message
      redirect_to new_charge_path

  end

  def downgrade
    current_user.downgrade_account
    redirect_to edit_user_registration_path(current_user)
  end
end
