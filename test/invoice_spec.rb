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

describe Invoice do
  it 'exists' do
    se = SalesEngine.from_csv({:invoices => "./data/invoices.csv"})

    i = Invoice.new({
                    :id          => 6,
                    :customer_id => 7,
                    :merchant_id => 8,
                    :status      => :pending,
                    :created_at  => Time.now,
                    :updated_at  => Time.now,
                    })

  expect(i).to be_a(Invoice)
  expect(i.id).to eq(6)
  end
end
