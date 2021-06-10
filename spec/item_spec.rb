require_relative './spec_helper'

RSpec.describe Item do
  context 'instantiation' do
    before :each do
      @ir = ItemRepository.new('spec/fixtures/items.csv', @sales_engine)
      @sales_engine = SalesEngine.new({
        items: 'spec/fixtures/items.csv',
        merchants: 'spec/fixtures/merchants.csv',
        invoices: 'spec/fixtures/invoices.csv',
        customers: 'spec/fixtures/customers.csv',
        invoice_items: 'spec/fixtures/invoice_items.csv',
        transactions: 'spec/fixtures/transactions.csv'
        })
      @ir.generate
      @item = @ir.all[1]
    end

    it 'exists' do
      expect(@item).to be_an_instance_of(Item)
    end

    it 'has attributes' do
      expect(@item.name).to eq('pencils')
      expect(@item.description).to eq('You can write with them')
      expect(@item.unit_price_to_dollars).to eq(0.12)
      expect(@item.created_at).to eq(Time.parse("2011-02-11 07:44:36 UTC"))
      expect(@item.updated_at).to eq(Time.parse("2004-03-24 10:25:11 UTC"))
      expect(@item.merchant_id).to eq(2)
    end

    it 'returns the price of the item in dollars formatted as a Float' do
      item1 = @ir.all[1]
      expect(item1.unit_price_to_dollars).to eq(0.12)
    end
  end
end
