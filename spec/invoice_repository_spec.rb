require_relative '../lib/invoice_repository'

RSpec.describe InvoiceRepository do
  let(:invoice_repository) { InvoiceRepository.new }
  describe '#initialize' do
    it 'exist' do
      # require 'pry'; binding.pry
      expect(invoice_repository).to be_a(InvoiceRepository)
    end
  end

  
end