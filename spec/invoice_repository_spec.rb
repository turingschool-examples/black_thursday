require_relative './spec_helper'

RSpec.describe InvoiceRepository do
  describe 'instantiation' do
    it 'exists' do
      se = SalesEngine.new({
         :items => 'spec/fixtures/items.csv',
         :merchants => 'spec/fixtures/merchants.csv',
         :invoices => 'spec/fixtures/invoices.csv'
       })
      ivr = InvoiceRepository.new('spec/fixtures/invoices.csv')
      
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
      @ivr = InvoiceRepository.new('spec/fixtures/invoices.csv')
    end

    it '' do
      
    end
  end
end