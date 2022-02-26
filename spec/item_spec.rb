require 'csv'
require_relative '../lib/item'
require_relative '../lib/sales_engine'
require_relative 'spec_helper'
require 'pry'

  RSpec.describe Item do
    before (:each) do
      @item = Item.new({ id: "263399361",
                        name: "Exotic Beaded Women&#39;s or Men&#39;s Handmade Bracelet or Anklet",
                        description: "Exotic Women&#39;s or Men&#39;s Handmade Bracelet or Anklet.  Sizes from 6 inches to 9 inches.  Made with premium crafted beads.  You may request colors and styles.  Most are made to order.  Email me after order is placed for specific or custom handmade designs, etc.",
                        unit_price: "4995",
                        merchant_id: "12334303",
                        created_at: "2016-01-11 11:23:02 UTC",
                        updated_at: "2012-10-27 09:12:45 UTC" })
                        # binding.pry
    end

    context 'Item' do
      it 'can read Item attributes' do
        expect(@item.id).to eq(263399361)
        expect(@item.name).to eq("Exotic Beaded Women&#39;s or Men&#39;s Handmade Bracelet or Anklet")
        expect(@item.description).to eq("Exotic Women&#39;s or Men&#39;s Handmade Bracelet or Anklet.  Sizes from 6 inches to 9 inches.  Made with premium crafted beads.  You may request colors and styles.  Most are made to order.  Email me after order is placed for specific or custom handmade designs, etc.")
    # binding.pry
        expect(@item.unit_price).to eq(4995.0)
        expect(@item.merchant_id).to eq(12334303)
        expect(@item.created_at).to eq("2016-01-11 11:23:02 UTC")
        expect(@item.updated_at).to eq("2012-10-27 09:12:45 UTC")
      end

      it '#unit_price_to_dollars can return price of items in dollars as float' do
        expect(@item.unit_price_to_dollars).to eq(4995.0)
      end


    end


end
