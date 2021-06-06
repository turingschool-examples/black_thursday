require_relative './spec_helper'

RSpec.describe InvoiceRepository do
  describe 'instantiation' do
    it 'exists' do
      se = SalesEngine.new({
         :items => 'spec/fixtures/items.csv',
         :merchants => 'spec/fixtures/merchants.csv',
         :invoices => 'spec/fixtures/invoices.csv'
       })
      ivr = InvoiceRepository.new('spec/fixtures/invoices.csv', se)
      
      expect(ivr).to be_a(InvoiceRepository)
    end
  end

  describe 'methods' do
    before :each do
      @se = SalesEngine.new({
        :items => 'spec/fixtures/items.csv',
        :merchants => 'spec/fixtures/merchants.csv',
        :invoices => 'spec/fixtures/invoices.csv'
      })
      @ivr = InvoiceRepository.new('spec/fixtures/invoices.csv', @se)
      @invoice1 = @ivr.all[0]
      @invoice2 = @ivr.all[-1]
    end

    it 'generates invoice instances' do
      @ivr.generate
      expect(@invoice1.id).to eq(1)
      expect(@invoice2.id).to eq(50)
    end

    it 'finds invoice by id or return nil' do
      expect(@ivr.find_by_id(1)).to eq(@invoice1)
      expect(@ivr.find_by_id(50)).to eq(@invoice2)
      expect(@ivr.find_by_id(1000000)).to eq(nil)
    end

    it 'finds all invoices by customer id or return []' do
      expect(@ivr.find_all_by_customer_id(1)).to eq(@invoice1)
      expect(@ivr.find_all_by_customer_id(10)).to eq(@invoice2)
      expect(@ivr.find_all_by_customer_id(1000000)).to eq([])
    end

    it 'can inspect rows' do
      expect(@ivr.inspect).to eq('#<InvoiceRepository 50 rows>')
    end
  end
end