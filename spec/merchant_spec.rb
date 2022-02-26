require 'csv'
require_relative '../lib/merchant'
require_relative '../lib/sales_engine'
require_relative 'spec_helper'
require 'pry'
  RSpec.describe Merchant do
    before (:each) do
      @merchant = Merchant.new({id: "12334105",
                              name: "Shopin1901"})
    end

      it 'can read merchant attributes' do
        expect(@merchant.id).to eq(12334105)
        expect(@merchant.name).to eq("Shopin1901")
      end



end
