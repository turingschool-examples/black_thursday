require 'RSpec'
require './lib/merchant'

RSpec.describe Merchant do
  describe 'instantiation' do

    it '::new' do
      merchant = Merchant.new({:id => 5,
                              :name => 'Turing School',
                              :created_at  => Time.now,
                              :updated_at  => Time.now})

    expect(merchant).to be_an_instance_of(Merchant)
    end

    it 'has attributes' do
      merchant = Merchant.new({:id => 5,
                              :name => 'Turing School',
                              :created_at  => Time.now,
                              :updated_at  => Time.now})

      expect(merchant.id).to eq(5)
      expect(merchant.name).to eq('Turing School')
    end
  end

  describe '#methods' do
    it '#update name' do
      merchant = Merchant.new({:id => 5,
                              :name => 'Turing School',
                              :created_at  => Time.now,
                              :updated_at  => Time.now})
      merchant.update_name({:name => 'George Washington University'})

      expect(merchant.name).to eq('George Washington University')
    end
  end
end
