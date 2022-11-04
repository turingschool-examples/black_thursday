require './lib/merchant_repository'
require './lib/item_repository'
require './lib/invoice_repository'
require './lib/invoice_item_repository'
require './lib/customer_repository'
require './lib/transaction_repository'
require './lib/item'
require './lib/merchant'
require './lib/invoice'
require './lib/invoice_item'
require './lib/customer'
require './lib/transaction'
require 'csv'

RSpec.describe SalesEngine do
  let(:se) {SalesEngine.from_csv({:items => './data/items.csv',
                                  :merchants => './data/merchants.csv',
                                  :invoices => './data/invoices.csv',
                                  :invoice_items => './data/invoice_items.csv',
                                  :customers => './data/customers.csv',
                                  :transactions => './data/transactions.csv'})}
  
  it 'is an instance of a sales engine' do
    
    expect(se).to be_a(SalesEngine)
  end

  it 'has a method to access the merchant repository with all the merchants loaded' do
    expect(se.merchants).to be_a(MerchantRepository)
    expect(se.merchants.find_by_name("Bowlsbychris")).to be_a(Merchant)
  end

  it 'has a method to access the item repository with all items loaded' do
    expect(se.items).to be_a(ItemRepository)
    expect(se.items.find_by_name("Silver Plated Clutch with Swarovski Element Crystals")).to be_a(Item)
  end

  it 'has a method to access the invoice repository with all items loaded' do
    expect(se.invoices).to be_a(InvoiceRepository)
    expect(se.invoices.find_by_id(4985)).to be_a(Invoice)
    expect(se.invoices.find_by_id(5000)).to eq(nil)
  end
end
