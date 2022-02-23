require './lib/merchant'
require 'pry'

RSpec.describe do
  context 'Iteration 1' do
    before(:each) do
      @m = Merchant.new({
                          id: 5,
                          name: 'Turing School'
                        })
    end

    it 'exists' do
      expect(@m).to be_an_instance_of(Merchant)
    end

    it 'has attributes' do
      expect(@m.id).to eq(5)
      expect(@m.name).to eq('Turing School')
    end
  end
  # context "Iteration 2" do
  #   before(:each) do

  #   end

  #   xit ' ' do
  #     expect().to eq()
  #   end

  #   xit ' ' do
  #     expect().to eq()
  #   end

  #   xit ' ' do
  #     expect().to eq()
  #   end
  # end
end
