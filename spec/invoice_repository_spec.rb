require 'rspec'
require './lib/invoice_repository'

describe InvoiceRepository do
  before (:each) do
    @ir = InvoiceRepository.new('./data/invoices.csv')
  end

  describe '#initialize' do
    it 'exists' do
      expect(@ir).to be_an_instance_of(InvoiceRepository)
    end

    it 'creates a repository of Invoice items' do
      expect(@ir.repository.class).to eq(Array)
      expect(@ir.repository.sample.class).to eq(Invoice)
    end
  end
end
