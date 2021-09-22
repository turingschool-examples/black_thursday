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
require './lib/transaction'

describe Transaction do
  it 'exists' do
    se = SalesEngine.from_csv({:transactions   => './data/transactions.csv'})

    t = Transaction.new({
                    :id                           => 6,
                    :invoice_id                   => 8,
                    :credit_card_number           => "4242424242424242",
                    :credit_card_expiration_date  => "0220",
                    :result                       => "success",
                    :created_at                   => Time.now,
                    :updated_at                   => Time.now,
                    })

  expect(t).to be_a(Transaction)
  expect(t.id).to eq(6)
  end
end
