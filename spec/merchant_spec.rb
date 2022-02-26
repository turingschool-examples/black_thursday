require './lib/merchant'
require './lib/sales_engine'
require 'pry'

RSpec.describe do
  context 'Iteration 1' do
    before(:each) do
      @m = Merchant.new({
                          id: 5,
                          name: 'Turing School',
                          created_at: '2010-12-10',
                          updated_at: '2011-12-04'
                        })
    end

    it 'exists' do
      expect(@m).to be_an_instance_of(Merchant)
    end

    it 'has attributes' do
      expect(@m.id).to eq(5)
      expect(@m.name).to eq('Turing School')
      expect(@m.created_at).to eq('2010-12-10')
      expect(@m.updated_at).to eq('2011-12-04')
    end
  end
end
