require 'SimpleCov'
SimpleCov.start

require_relative '../lib/sales_engine'
require_relative '../lib/item_repository'
require_relative '../lib/merchant_repository'
require_relative '../lib/invoice_repository'
require_relative '../lib/invoice_item_repository'
require_relative '../lib/customer_repository'
require_relative '../lib/transaction_repository'
require_relative '../lib/sales_analyst'

RSpec.describe SalesEngine do
  before(:each) do
    @se = SalesEngine.from_csv({
                               :items         => './data/items.csv',
                               :merchants     => './data/merchants.csv',
                               :invoices      => './data/invoices.csv',
                               :invoice_items => './data/invoice_items.csv',
                               :customers     => './data/customers.csv',
                               :transactions  => './data/transactions.csv'
                             })
  end

  it 'exists' do
    expect(@se).to be_an_instance_of(SalesEngine)
  end

  it 'initializes with attributes that create repository instances' do
    expect(@se.items).to be_an_instance_of(ItemRepository)
    expect(@se.merchants).to be_an_instance_of(MerchantRepository)
  end

  it 'can initialize sales analyst' do
    sales_analyst = @se.analyst

    expect(sales_analyst).to be_an_instance_of(SalesAnalyst)
  end
end
