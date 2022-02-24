require 'csv'
require './lib/merchant'
require './lib/sales_engine'
require './spec/spec_helper'

  RSpec.describe Merchant do
    before (:each) do
      @merchant = Merchant.new({id: "12334105",
                              name: "Shopin1901",
                              created_at: "2010-12-10",
                              updated_at: "2011-12-04"})
    end

    context 'merchant' do
      it 'can read merchant attributes' do
        expect(@merchant.id).to eq("12334105")
        expect(@merchant.name).to eq("Shopin1901")
        expect(@merchant.created_at).to eq("2010-12-10")
        expect(@merchant.updated_at).to eq("2011-12-04")
      end
    end


end
