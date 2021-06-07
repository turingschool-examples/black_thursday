require_relative 'spec_helper'

RSpec.describe InvoiceItemRepository do
  before :each do
    @path = "fixture/invoice_item_fixture.csv"
    @invoice_item_repo = InvoiceItemRepository.new(@path)
  end

  describe 'instantiation' do
    it 'exists' do
      expect(@invoice_item_repo).to be_an(InvoiceItemRepository)
    end

    it 'returns an array of all known invoices with readable attributes' do
      expect(@invoice_item_repo.all).to be_an(Array)
      expect(@invoice_item_repo.all.length).to eq(6)
      expect(@invoice_item_repo.all.first.id).to eq(14400)
      expect(@invoice_item_repo.all.first.item_id).to eq(263532662)
      expect(@invoice_item_repo.all.first.invoice_id).to eq(3233)
      expect(@invoice_item_repo.all.first.quantity).to eq(3)
      expect(@invoice_item_repo.all.first.unit_price).to eq(37328)
      expect(@invoice_item_repo.all.first.created_at).to be_a(Time)
      expect(@invoice_item_repo.all.first.updated_at).to be_a(Time)
    end
  end
end
