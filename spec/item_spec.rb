require_relative '../lib/sales_engine'
require_relative '../lib/item_repository'
require_relative '../lib/item'
require 'bigdecimal/util'

RSpec.describe Item do

  describe '#initialize' do
    item = Item.new({
                      :id          => 1,
                      :name        => "Pencil",
                      :description => "You can use it to write things",
                      :unit_price  => "1099",
                      :created_at  => Time.now,
                      :updated_at  => Time.now,
                      :merchant_id => 2
                    })

    it 'exists' do
      expect(item).to be_instance_of(Item)
    end

    it 'has attributes available' do
      expect(item.id).to eq(1)
      expect(item.name).to eq("Pencil")
      expect(item.description).to eq("You can use it to write things")
      expect(item.unit_price).to eq(10.99)
      expect(item.created_at.class).to eq(Time)
      expect(item.updated_at.class).to eq(Time)
      expect(item.merchant_id).to eq(2)
    end
  end

  describe '#unit price to dollars' do
    sales_engine = SalesEngine.from_csv({
                                          :items     => "./data/items.csv",
                                          :merchants => "./data/merchants.csv",
                                          :invoices => "./data/invoices.csv",
                                          :customers => "./data/customers.csv",
                                          :invoice_items => "./data/invoice_items.csv",
                                          :transactions => "./data/transactions.csv"
                                          })
    repo = sales_engine.items

     it 'has a unit price' do
        expected = repo.find_by_id(263397059)

        expect(expected.unit_price_to_dollars).to eq(130.0)
        expect(expected.unit_price_to_dollars.class).to eq(Float)
     end
  end

  describe '#time_check' do

    item = Item.new({
                      :id          => 1,
                      :name        => "Pencil",
                      :description => "You can use it to write things",
                      :unit_price  => "1099",
                      :created_at  => Time.now,
                      :updated_at  => Time.now,
                      :merchant_id => 2
                    })

    it 'returns input as originally passed in if input is class Time' do
      time_object = Time.parse("2007-06-04 21:35:10 UTC")
      expect(item.time_check(time_object)).to eq(time_object)
    end

    it 'returns input converted to Time object if input is not class Time' do
      expect(item.time_check("2007-06-04 21:35:10 UTC")).to eq(Time.parse("2007-06-04 21:35:10 UTC"))
    end
  end
end
