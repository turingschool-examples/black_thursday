require_relative '../lib/merchant'

RSpec.describe Merchant do

  describe 'initializes' do
    merchant = Merchant.new({ :id => 5, :name => "Turing School", :created_at => "2000-03-28"})

    it 'exists' do
      expect(merchant).to be_instance_of(Merchant)
    end

    it 'can access instance variables' do
      expect(merchant.id).to eq(5)
      expect(merchant.name).to eq("Turing School")
    end
  end

end
