class ChargesController < ApplicationController

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
      current_user.upgrade_role
      flash[:notice] = "Thank you for Upgrading to Premium. Enjoy all the privileges of a Premium User."
      redirect_to users_show_path
    end

    rescue Stripe::CardError => e
      flash[:alert] = e.message
      redirect_to new_charge_path

  end
end
