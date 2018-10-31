require "rails_helper"
require 'feature_helper'

describe 'Merchant can fulfill order' do
  include FeatureHelper


  it 'can click fulfill' do
    skip
  end

  describe 'Order Status' do

    it "completes order of only this merchant's item" do
      skip
    end

    it "does not complete joint merchant orders" do
      skip
    end

    it "completes orders that are partailly complete" do
      skip
    end
  end

  describe 'Order Items' do

    it 'updates order items to fulfilled status' do
      skip
    end

    it 'affects item inventory' do
      skip
    end

  end

  describe 'Admin' do

    it 'Admin cannot fulfill orders' do
      skip
    end

  end


end
