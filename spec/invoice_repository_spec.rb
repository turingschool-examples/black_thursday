require_relative '../lib/invoice_repository'
require_relative '../lib/invoice'

RSpec.describe InvoiceRepository do
  it 'exists' do
    ivr = InvoiceRepository.new

    expect(ivr).to be_a(InvoiceRepository)
  end  

  it 'starts with no invoices' do
    ivr = InvoiceRepository.new

    expect(ivr.data).to eq([])
  end
  describe '#module methods' do
    it 'can return all invoices' do
      ivr = InvoiceRepository.new
  
      i = Invoice.new(
        :id          => 6,
        :customer_id => 7,
        :merchant_id => 8,
        :status      => "pending",
        :created_at  => created = Time.now.to_s,
        :updated_at  => updated = Time.now.to_s
      )
  
      ivr.all << i 
  
      expect(ivr.all).to eq([i])
    end

    it 'find invoices by id' do
      ivr = InvoiceRepository.new
      i = Invoice.new(
        :id          => 6,
        :customer_id => 7,
        :merchant_id => 8,
        :status      => "pending",
        :created_at  => created = Time.now.to_s,
        :updated_at  => updated = Time.now.to_s
      )

      ivr.all << i 

      expect(ivr.find_by_id(6)).to eq(i)
      expect(ivr.find_by_id(2)).to eq(nil)
    end
  end
end
