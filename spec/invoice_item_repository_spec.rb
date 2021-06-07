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

  end
end