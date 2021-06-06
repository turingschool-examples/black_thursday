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
  end
end