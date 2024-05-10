class Stripe::CheckoutController < ApplicationController
  def pricing
    lookup_keys = %w[month three_month six_months one_year]
    @prices = Stripe::Price.list(lookup_keys: lookup_keys, active: true, expand: ['data.product']).data.sort_by(&:unit_amount) 
    @monthly_price = @prices.find { |price| price.lookup_key == 'month' }
    @quarterly_price = @prices.find { |price| price.lookup_key == 'three_month' }
    @halfyearly_price = @prices.find { |price| price.lookup_key == 'six_months' }
    @yearly_price = @prices.find { |price| price.lookup_key == 'one_year' } 
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
    customer = Stripe::Customer.retrieve("#{current_user.stripe_customer_id}")
    subscriptions = Stripe::Subscription.list({ customer: customer.id })
    user = current_user
    user.update(
      plan: subscriptions.data.first.items.data[0].price.lookup_key,
      subscription_status: subscriptions.data.first.status,
      subscription_ends_at: Time.at(subscriptions.data.first.current_period_end).to_datetime
    )
    user.save
    flash[:notice] = 'success'
    redirect_to root_path
  end

  def cancel
    flash[:notice] = 'failure'
    redirect_to pricing_path
  end
end