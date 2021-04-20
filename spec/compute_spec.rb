require_relative '../lib/compute'

RSpec.describe Compute do

  describe 'mathematical functions' do
    data_set = [1, 4, 22, 10, 4, 3, 17, 30, 12, 16]

    it 'calculates the mean of given set' do
      expect(Compute.mean(data_set.sum, data_set.length)).to eq(11.9)
    end

    it 'returns mean in bigdecimal format' do
      big_decimals = data_set.map { |num| num.to_d }
      expect(Compute.mean(big_decimals.sum, data_set.length)).to eq(0.119e2)
    end

    it 'calculates standard deviation of given set' do
      expect(Compute.standard_deviation(data_set)).to eq(9.42)
    end
  end
end
