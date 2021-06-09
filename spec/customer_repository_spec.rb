require 'rspec'
require_relative './spec_helper'

RSpec.describe CustomerRepository do
  describe 'instantiation' do
    it 'exists' do
      se = SalesEngine.new({
        :items => 'spec/fixtures/items.csv',
        :merchants => 'spec/fixtures/merchants.csv',
        invoice_items: 'spec/fixtures/invoice_items.csv',
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

    it "generates CustomerRepository" do
      expect(@customer1.id).to eq(1)
      expect(@customer1.first_name).to eq("Joey")
      expect(@customer1.last_name).to eq("Ondricka")
    end

    it 'finds customer by id or return nil' do
      expect(@cr.find_by_id(1)).to eq(@customer1)
      expect(@cr.find_by_id(2)).to eq(@customer2)
      expect(@cr.find_by_id(1000000)).to eq(nil)
    end

    it 'finds all customers by first name substring or []' do
      expect(@cr.find_all_by_first_name("Joey")).to eq([@customer1])
      expect(@cr.find_all_by_first_name("Jo")).to eq([@customer1, @customer9])
      expect(@cr.find_all_by_first_name("Cecelia")).to eq([@customer2])
      expect(@cr.find_all_by_first_name("Ce")).to eq([@customer2])
      expect(@cr.find_all_by_first_name("FriskyBuiscuit")).to eq([])
    end

    it 'finds all customers by last name substring or []' do
      expect(@cr.find_all_by_last_name("Ondricka")).to eq([@customer1])
      expect(@cr.find_all_by_last_name("Ond")).to eq([@customer1])
      expect(@cr.find_all_by_last_name("Osinski")).to eq([@customer2])
      expect(@cr.find_all_by_last_name("Osi")).to eq([@customer2])
      expect(@cr.find_all_by_last_name("FriskyBuiscuit")).to eq([])
    end

    it 'creates new invoice_item instance with given attributes' do
      attributes = {
        id:         21,
        first_name: "Frisky",
        last_name: "Biscuit",
        created_at: Time.now.to_s,
        updated_at: Time.now.to_s
      }

      @cr.create(attributes)
      new_customer = @cr.all.last
      expect(new_customer.id).to eq(21)
      expect(@cr.all.length).to eq(21)
      expect(new_customer.updated_at).to eq(new_customer.created_at)
      @cr.create(attributes)
      newer_customer = @cr.all.last
      expect(newer_customer.id).to eq(22)
    end

    it 'updates customer first & last name by given id' do
      new_name = { first_name: "Frisky", last_name: "Biscuit"}
      prev_updated_at = @customer1.updated_at
      @cr.update(1, new_name)

      expect(@customer1.first_name).to eq("Frisky")
      expect(@customer1.last_name).to eq("Biscuit")
      expect(prev_updated_at).to_not eq(@customer1.updated_at)
    end
  end
end