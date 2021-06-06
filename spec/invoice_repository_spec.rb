require_relative 'spec_helper'

RSpec.describe InvoiceRepository do
  before :each do
    invoice_repo = InvoiceRepository.new()
  end
  describe 'instantiation' do
    it 'exists' do


      expect(invoice_repo).to be_an(InvoiceRepository)
    end

    it 'has attributes' do

    end
  end
end
