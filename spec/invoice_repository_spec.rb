require_relative 'spec_helper'

RSpec.describe InvoiceRepository do
  before :each do
    @path = "fixture/invoice_fixture.csv"
    @invoice_repo = InvoiceRepository.new(@path)
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
      # require "pry"; binding.pry
      expect(@invoice_repo.find_by_id(25)).to eq(@invoice_repo.all.first)
    end
  end
end
