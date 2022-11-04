# frozen_string_literal: true

require './lib/calculable'
require 'bigdecimal'

describe Calculable do
  before(:each) do
    class Dummy
      include Calculable
    end

    @dummy = Dummy.new
    @convert1 = '1200'
    @convert2 = 12.50
    @convert3 = BigDecimal(1000, 4)
    @convert4 = 1500

    @average1 = [15, 12, 20]
    @average2 = [25, 16, 2]

    @percent1 = [72, 100]
    @percent2 = [5, 10]
    @percent3 = [10, 1500]
    @percent4 = [10, 10]

    @deviation_set1 = [3, 4, 5]
    @deviation_set2 = [15, 12, 20]
    @deviation_set3 = [25, 16, 2]
    @deviation_set_all = [3, 4, 5, 15, 12, 20, 25, 16, 2]
    @deviation_all_avg = @dummy.average(@deviation_set_all.sum, @deviation_set_all.length)
    @deviation_avg1 = @dummy.average(@deviation_set1.sum, @deviation_set1.count)
    @deviation_avg2 = @dummy.average(@deviation_set2.sum, @deviation_set2.count)
    @deviation_avg3 = @dummy.average(@deviation_set3.sum, @deviation_set3.count)
    @deviation1 = @dummy.deviation(@deviation_set1, @deviation_avg1)
  end

  describe '#price_converter' do
    it 'converts a number from string or integer to a float representation' do
      expect(@dummy.price_converter(@convert1)).to eq("12.00")
      expect(@dummy.price_converter(@convert2)).to eq("12.5")
      expect(@dummy.price_converter(@convert3)).to eq("0.1e4")
      expect(@dummy.price_converter(@convert4)).to eq("15.00")
    end
  end

  describe '#average' do
    it 'calculates the mean average of the sum and count' do
      expect(@dummy.average(@average1[0], @average1[1])).to eq(1.25)
      expect(@dummy.average(@average2[0], @average2[1])).to eq(1.5625)
    end
  end

  describe '#deviation' do
    it 'calculates the sample deviation of a set of numbers and the mean average' do
      expect(@dummy.deviation(@deviation_set1, @deviation_avg1)).to eq(1)
      expect(@dummy.deviation(@deviation_set2, @deviation_avg2)).to eq(4.041451884327381)
      expect(@dummy.deviation(@deviation_set3, @deviation_avg3)).to eq(11.590225767142474)
    end
  end

  describe '#percent' do
    it 'calculates the percentage of a value and the total value' do
      expect(@dummy.percent(@percent1[0], @percent1[1])).to eq(72)
      expect(@dummy.percent(@percent2[0], @percent2[1])).to eq(50)
      expect(@dummy.percent(@percent3[0], @percent3[1])).to eq(0.67)
      expect(@dummy.percent(@percent4[0], @percent4[1])).to eq(100)
    end
  end

  describe '#deviation_difference' do
    it 'calculates the difference between deviation' do
      expect(@dummy.deviation_difference(@deviation1, 
        @deviation_set1.count, @deviation_all_avg)).to eq(-8)
    end
  end
end
