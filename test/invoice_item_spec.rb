require './lib/item'
require './lib/itemrepository'
require 'bigdecimal'
require 'bigdecimal/util'
require 'objspace'
require './lib/sales_engine'
require './lib/merchant'
require './lib/merchantrepository'
require './lib/invoice'
require 'csv'
require './lib/invoice_item'
require './lib/invoice_item_repo'
require 'rspec'

describe InvoiceItem do
  it 'exists' do
    se = SalesEngine.from_csv({:invoice_item => "./data/invoice_items.csv"})

    i = InvoiceItem.new({
                    :id         => 6,
                    :item_id    => 7,
                    :invoice_id => 8,
                    :quantity   => 1,
                    :unit_price => BigDecimal(10.99, 4),
                    :created_at  => Time.now,
                    :updated_at  => Time.now,
                    })

    expect(i).to be_a(InvoiceItem)
    expect(i.id).to eq(6)
  end

  it 'returns unit_price in dollars' do
    se = SalesEngine.from_csv({:invoice_item => "./data/invoice_items.csv"})

    i = InvoiceItem.new({
                    :id         => 6,
                    :item_id    => 7,
                    :invoice_id => 8,
                    :quantity   => 1,
                    :unit_price => BigDecimal(10.99, 4),
                    :created_at  => Time.now,
                    :updated_at  => Time.now,
                    })

    expect(i.unit_price_to_dollars).to eq(10.99)
  end
end
