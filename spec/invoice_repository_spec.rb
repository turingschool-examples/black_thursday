require_relative 'spec_helper'

RSpec.describe InvoiceRepository do
  before :each do
    @mock_engine = double('InvoiceRepository')
    @path = "fixture/invoice_fixture.csv"
    @invoice_repo = InvoiceRepository.new(@path, @mock_engine)
  end
  describe 'instantiation' do
    it 'exists' do
      expect(@invoice_repo).to be_an(InvoiceRepository)
    end

    it 'returns an array of all known invoices with readable attributes' do
      expect(@invoice_repo.all).to be_an(Array)
      expect(@invoice_repo.all.length).to eq(6)
      expect(@invoice_repo.all.first.id).to eq(25)
      expect(@invoice_repo.all.first.customer_id).to eq(6)
      expect(@invoice_repo.all.first.merchant_id).to eq(12334264)
      expect(@invoice_repo.all.first.status).to eq('returned')
      expect(@invoice_repo.all.first.created_at).to be_a(Time)
      expect(@invoice_repo.all.first.updated_at).to be_a(Time)
    end
  end

  describe 'methods' do
    it 'can find an invoice by its id' do
      expect(@invoice_repo.find_by_id(25)).to eq(@invoice_repo.all.first)
    end

    it 'can find all by customer_id' do
      expected = @invoice_repo.all[-2..-1]
      expect(@invoice_repo.find_all_by_customer_id(7)).to eq(expected)
      expect(@invoice_repo.find_all_by_customer_id(9)).to eq([])
    end

    it 'can find all invoices by merchant_id' do
      expected = @invoice_repo.all[2]
      expect(@invoice_repo.find_all_by_merchant_id(12335319)).to eq([expected])
    end

    it 'can find all invoices by status' do
      expected = @invoice_repo.all[1..4]
      expect(@invoice_repo.find_all_by_status('shipped')).to eq(expected)
      expect(@invoice_repo.find_all_by_status('pending')).to eq([@invoice_repo.all.last])
      expect(@invoice_repo.find_all_by_status('returned')).to eq([@invoice_repo.all.first])
    end

    it 'can create a new invoice with provided attributes' do
      attributes = {
                      :id => nil,
                      :customer_id => 11,
                      :merchant_id => 12335319,
                      :status => 'returned',
                      :created_at => Time.now,
                      :updated_at => Time.now
                    }

      @invoice_repo.create(attributes)

      expect(@invoice_repo.all.last.id).to eq(31)
      expect(@invoice_repo.all.last.customer_id).to eq(11)
      expect(@invoice_repo.all.last.merchant_id).to eq(12335319)
      expect(@invoice_repo.all.last.status).to eq('returned')
    end

    it 'can update provided attributes with id' do
      attributes = {:status => 'returned'}

      @invoice_repo.update(30, attributes)
      expect(@invoice_repo.all.last.status).to eq('returned')

      attributes_1 = {:merchant_id => 1111}

      @invoice_repo.update(27, attributes_1)
      expect(@invoice_repo.all[2].merchant_id).to eq(12335319)
    end

    it 'can delete the invoice with the provided id' do
      @invoice_repo.delete(31)
      expect(@invoice_repo.all.last.id).to eq(30)
    end
  end
end
