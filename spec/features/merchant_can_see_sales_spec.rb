require "rails_helper"
require 'feature_helper'

describe 'Merchant Sold Orders' do
  include FeatureHelper

  before(:each) do
    # -- shop --
    @merch = create(:user, role: 1)
    create_list(:item, 3, user_id: @merch.id)
    # -- purchaser --
    @user = create(:user, role: 0)
    login(@user)
    shop; checkout
    shop; checkout
    shop; checkout
    login(@merch)
    visit dashboard_orders_path
  end

  it 'Orders were made by other users' do
    order = page.all('.order').first
    expect(order).to_not have_content(@merch.name)

  end


end
