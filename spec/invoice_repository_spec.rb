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
      @invoice2 = @ivr.all[1]
      @invoice3 = @ivr.all[2]
      @invoice4 = @ivr.all[3]
      @invoice5 = @ivr.all[4]
    end

    it 'generates invoice instances' do
      @ivr.generate
      expect(@invoice1.id).to eq(1)
      expect(@invoice2.id).to eq(2)
    end

    it 'finds invoice by id or return nil' do
      expect(@ivr.find_by_id(1)).to eq(@invoice1)
      expect(@ivr.find_by_id(2)).to eq(@invoice2)
      expect(@ivr.find_by_id(1000000)).to eq(nil)
    end

    it 'finds all invoices by customer id or return []' do
      expect(@ivr.find_all_by_customer_id(1)).to eq([@invoice1])
      expect(@ivr.find_all_by_customer_id(2)).to eq([@invoice2, @invoice3])
      expect(@ivr.find_all_by_customer_id(1000000)).to eq([])
    end

    it 'finds all invoices by merchant id or return []' do
      expect(@ivr.find_all_by_merchant_id(12335938)).to eq([@invoice1])
      expect(@ivr.find_all_by_merchant_id(12336299)).to eq([@invoice2, @invoice5])
      expect(@ivr.find_all_by_merchant_id(0)).to eq([])
    end

    it 'finds all invoices by status' do
      expect(@ivr.find_all_by_status('pending')).to eq([@invoice1, @invoice4, @invoice5])
      expect(@ivr.find_all_by_status('shipped')).to eq([@invoice2, @invoice3])
      expect(@ivr.find_all_by_status('returned')).to eq([])
    end

    it 'creates new invoice instance with given attributes' do
      attributes = {
        customer_id: 6,
        merchant_id: 6,
        status: 'pending',
        created_at: Time.now.to_s,
        updated_at: Time.now.to_s,
      }

      @ivr.create(attributes)
      new_invoice = @ivr.all.last
      expect(new_invoice.id).to eq(6)
      expect(@ivr.all.length).to eq(6)
      expect(new_invoice.created_at.class).to eq(Time)
      expect(new_invoice.updated_at).to eq(new_invoice.created_at)
      expect(@ivr.find_by_id(6).merchant_id).to eq(6)
      @ivr.create(attributes)
      newer_item = @ivr.all.last
      expect(newer_item.id).to eq(7)
    end

    it 'updates invoice by id with given status' do
      new_status = { status: 'shipped' }
      prev_updated_at = @invoice1.updated_at
      @ivr.update(1, new_status)

      expect(@invoice1.merchant_id).to eq(12335938)
      expect(@invoice1.updated_at).to be_an_instance_of(Time)
      expect(@invoice1.status).to eq('shipped')
      expect(prev_updated_at).to_not eq(@invoice1.updated_at)
    end

    it 'can inspect rows' do
      expect(@ivr.inspect).to eq('#<InvoiceRepository 5 rows>')
    end
  end
end