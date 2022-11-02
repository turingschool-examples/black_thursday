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
    
    it 'will have a time' do 
        i = Invoice.new({
          :id          => 6,
          :customer_id => 7,
          :merchant_id => 8,
          :status      => "pending",
          :created_at  => "2022-11-02 11:33:36.699596 -0600",
          :updated_at  =>  "2022-11-02 11:33:36.699596 -0600",
        })
          
          expect(i.created_at).to eq("2022-11-02 11:33:36.699596 -0600")
          expect(i.updated_at).to eq("2022-11-02 11:33:36.699596 -0600")
    end  
  end      
end 
