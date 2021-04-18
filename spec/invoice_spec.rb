require './lib/invoice'

RSpec.describe Invoice do
  describe 'instantiation' do
    it '::new' do
      invoice = Invoice.new({:id => 6,
                             :customer_id => 7,
                             :merchant_ir => 8,
                             :status => 'pending',
                             :created_at => Time.now,
                             :updated_at => Time.now}, @repo)

      expect(invoice).to be_an_instance_of(Invoice)
    end

    it 'has attributes' do
      invoice = Invoice.new({:id => 6,
                             :customer_id => 7,
                             :merchant_id => 8,
                             :status => 'pending',
                             :created_at => Time.now,
                             :updated_at => Time.now}, @repo)

      expect(invoice.id).to eq(6)
      expect(invoice.customer_id).to eq(7)
      expect(invoice.merchant_id).to eq(8)
      expect(invoice.status).to eq('pending')
      expect(invoice.created_at).to be_an_instance_of(Time)
      expect(invoice.updated_at).to be_an_instance_of(Time)
    end
  end
end