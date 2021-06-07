require_relative 'spec_helper'

RSpec.describe Merchant do
  describe '#initialize' do
    it 'exists' do
      mock_repo = double('MerchantRepository')
      merchant = Merchant.new({:id => 5, :name => "Turing School"}, mock_repo)

      expect(merchant).to be_a(Merchant)
    end

    it 'has attributes' do
      mock_repo = double('MerchantRepository')
      merchant = Merchant.new({:id => 5, :name => "Turing School"}, mock_repo)

      expect(merchant.id).to eq(5)
      expect(merchant.name).to eq("Turing School")
    end
  end
end
