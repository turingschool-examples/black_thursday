require './lib/invoice'

RSpec.describe Invoice do
  describe 'instantiation' do
    it '::new' do
      mock_repo = double('InvoiceRepo')
      invoice = Invoice.new({:id => 6,
                             :customer_id => 7,
                             :merchant_ir => 8,
                             :status => 'pending',
                             :created_at => Time.now,
                             :updated_at => Time.now}, mock_repo)

      expect(invoice).to be_an_instance_of(Invoice)
    end

    it 'has attributes' do
      mock_repo = double('InvoiceRepo')
      invoice = Invoice.new({:id => 6,
                             :customer_id => 7,
                             :merchant_id => 8,
                             :status => 'pending',
                             :created_at => Time.now,
                             :updated_at => Time.now}, mock_repo)

      expect(invoice.id).to eq(6)
      expect(invoice.customer_id).to eq(7)
      expect(invoice.merchant_id).to eq(8)
      expect(invoice.status).to eq(:pending)
      expect(invoice.created_at).to be_an_instance_of(Time)
      expect(invoice.updated_at).to be_an_instance_of(Time)
    end
  end

  describe '#methods' do
    it '#updates status' do
      mock_repo = double('InvoiceRepo')
      invoice = Invoice.new({:id => 6,
                            :customer_id => 7,
                            :merchant_id => 8,
                            :status => 'pending',
                            :created_at => Time.now,
                            :updated_at => Time.now}, mock_repo)  

      invoice.update_status({:status => :shipped})
      expect(invoice.status).to eq(:shipped)
    end

    it '#updates updated at time' do
    mock_repo = double('InvoiceRepo')
    invoice = Invoice.new({:id => 6,
                           :customer_id => 7,
                           :merchant_id => 8,
                           :status => 'pending',
                           :created_at => Time.now,
                           :updated_at => Time.now}, mock_repo)
  
    invoice.update_updated_at({:updated_at => Time.now})
  
    expect(invoice.updated_at).to be_an_instance_of(Time)
  end
  end
end