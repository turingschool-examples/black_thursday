require './lib/invoice'

RSpec.describe Invoice do 
  describe '#initialize' do 
    it 'will exist and have attributes' do 
      i = Invoice.new({
        :id          => 6,
        :customer_id => 7,
        :merchant_id => 8,
        :status      => "pending",
        :created_at  => Time.now,
        :updated_at  => Time.now,
      })

      expect(i).to be_a(Invoice)
      expect(i.id).to eq(6)
      expect(i.customer_id).to eq(7)
      expect(i.merchant_id).to eq(8)
      expect(i.status).to eq("pending")
      
    end 
  end 
end 
