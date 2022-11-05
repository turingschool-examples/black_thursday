require 'simplecov'
SimpleCov.start
require './lib/merchant_repository'
require './lib/merchant'
require './lib/sales_engine'
require 'pry'

RSpec.describe SalesEngine do
  it 'exists' do
    se = SalesEngine.new

    expect(se).to be_instance_of(SalesEngine)
  end

  it 'has merchants' do
    se = SalesEngine.new

    expect(se.merchants).to be_instance_of(MerchantRepository)
  end

  it 'has items' do
    se = SalesEngine.new

    expect(se.items).to be_instance_of(ItemRepository)
  end

  it 'has invoices' do
    se = SalesEngine.new
    
    expect(se.invoices).to be_instance_of(InvoiceRepository)
  end

  xit 'creates a merchant and merchant repository' do
    se = SalesEngine.from_csv({
                                items: './data/items.csv',
                                merchants: './data/merchants.csv'
                              })
    mr = se.merchants
    merchant = mr.find_by_name('CJsDecor')
    expect(mr).to be_instance_of(MerchantRepository)
    expect(merchant).to be_instance_of(Merchant)
  end

  xit 'creates item and item repository' do
    se = SalesEngine.from_csv({
                                items: './data/items.csv',
                                merchants: './data/merchants.csv'
                              })
    ir   = se.items
    item = ir.find_by_name('disney scrabble frames')
    expect(ir).to be_instance_of(ItemRepository)
    expect(item).to be_instance_of(Item)
  end

  xit 'creates invoice and invoice repository' do
    se = SalesEngine.from_csv({
                                items: './data/items.csv',
                                merchants: './data/merchants.csv',
                                invoices: './data/invoices.csv'
                              })
    inr   = se.invoices
    invoice = inr.find_by_id(6)
    expect(inr).to be_instance_of(ItemRepository)
    expect(invoice).to be_instance_of(Invoice)
  end
end
