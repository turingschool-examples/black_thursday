require 'rspec'
require_relative './spec_helper'

RSpec.describe CustomerRepository do
  describe 'instantiation' do
    it 'exists' do
      se = SalesEngine.new({
        :items => 'spec/fixtures/items.csv',
        :merchants => 'spec/fixtures/merchants.csv',
        invoice_item: 'spec/fixtures/invoice_items.csv',
        :invoices => 'spec/fixtures/invoices.csv',
        :customers => 'spec/fixtures/customers.csv'
       })
      cr = CustomerRepository.new('spec/fixtures/customers.csv', se)

      expect(cr).to be_a(CustomerRepository)
    end
  end

  describe 'methods' do
    before :each do
      @sales_engine = SalesEngine.new({
        items: 'spec/fixtures/items.csv',
        merchants: 'spec/fixtures/merchants.csv',
        invoice_item: 'spec/fixtures/invoice_items.csv',
        invoices: 'spec/fixtures/invoices.csv',
        customers: 'spec/fixtures/customers.csv'
        })
      @cr = CustomerRepository.new('spec/fixtures/customers.csv', @sales_engine)
      @customer1 = @cr.all[0]
      @customer2 = @cr.all[1]
      @customer3 = @cr.all[2]
      @customer4 = @cr.all[3]
      @customer5 = @cr.all[4]
      @customer6 = @cr.all[5]
      @customer7 = @cr.all[6]
      @customer8 = @cr.all[7]
      @customer9 = @cr.all[8]
      @customer10 = @cr.all[9] 
      @customer11 = @cr.all[10] 
      @customer12 = @cr.all[11]
      @customer13 = @cr.all[12] 
      @customer14 = @cr.all[13] 
      @customer15 = @cr.all[14] 
      @customer16 = @cr.all[15] 
      @customer17 = @cr.all[16] 
      @customer18 = @cr.all[17] 
      @customer19 = @cr.all[18] 
      @customer20 = @cr.all[19]
    end

    it "generates CustomerRepository " do
      expect(@customer1.id).to eq(1)
      expect(@customer1.first_name).to eq("Joey")
      expect(@customer1.last_name).to eq("Ondricka")
    end
  end
end