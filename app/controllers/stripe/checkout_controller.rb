class Stripe::CheckoutController < ApplicationController
  def pricing
    lookup_keys = %w[monthly quarterly halfyearly yearly]
    @prices = Stripe::Price.list(lookup_keys: lookup_keys, active: true, expand: ['data.product']).data.sort_by(&:unit_amount) 
    @monthly_price = @prices.find { |price| price.lookup_key == 'monthly' }
    @quarterly_price = @prices.find { |price| price.lookup_key == 'quarterly' }
    @halfyearly_price = @prices.find { |price| price.lookup_key == 'halfyearly' }
    @yearly_price = @prices.find { |price| price.lookup_key == 'yearly' } 
  end

  def checkout
    session = Stripe::Checkout::Session.create({
      customer: current_user.stripe_customer_id,
      mode: 'subscription',
      line_items: [{
        quantity: 1,
        price: params[:price_id]
      }],
      success_url: stripe_checkout_success_url,
      cancel_url: stripe_checkout_cancel_url, 
    })
    redirect_to session.url, allow_other_host: true 
  end

  def success
    flash[:notice] = 'success'
    redirect_to root_path
  end

  def cancel
    flash[:notice] = 'failure'
    redirect_to pricing_path
  end
end