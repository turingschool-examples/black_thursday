require 'RSpec'
require './lib/merchant'

RSpec.describe Merchant do
  describe 'instantiation' do
    it '::new' do
      mock_repo = double('MerchantRepo') 
      merchant = Merchant.new({:id => 5, 
                               :name => 'Turing School',
                               :created_at => Time.now,
                               :updated_at => Time.now}, mock_repo)

      expect(merchant).to be_an_instance_of(Merchant)
    end

    it 'has attributes' do
      mock_repo = double("MerchantRepo") 
      merchant = Merchant.new({:id => 5, 
                               :name => 'Turing School',
                               :created_at => Time.now,
                               :updated_at => Time.now}, mock_repo)

      expect(merchant.id).to eq(5)
      expect(merchant.name).to eq('Turing School')
    end
  end

  describe '#methods' do
    it '#update name' do
      mock_repo = double("MerchantRepo") 
      merchant = Merchant.new({:id => 5, 
                               :name => 'Turing School',
                               :created_at => Time.now,
                               :updated_at => Time.now}, mock_repo)

      merchant.update_name({:name => 'George Washington University'})

      expect(merchant.name).to eq('George Washington University')
    end

    it '#update id' do
      mock_repo = double('ItemRepo')
      merchant = Merchant.new({:id => 5, 
                               :name => 'Turing School',
                               :created_at => Time.now,
                               :updated_at => Time.now}, mock_repo)

      new_id = 10000

      expect(merchant.update_id(10000)).to eq 10001
    end
  end
end
