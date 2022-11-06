# frozen_string_literal: true

require './lib/timeable'
require 'time'

describe Timeable do
  before(:each) do
    class Dummy
      include Timeable
    end

    @dummy = Dummy.new
    @convert1 = 2
    @convert2 = 7
    @convert3 = 5
  end

  describe '#convert_int_to_day' do
    it 'converts a number index value to a day of week string' do
      expect(@dummy.convert_int_to_day(@convert1)).to eq('Tuesday')
      expect(@dummy.convert_int_to_day(@convert2)).to eq(nil)
      expect(@dummy.convert_int_to_day(@convert3)).to eq('Friday')
    end
  end

  describe '#month_to_int' do
    it 'converts a string representing month of the year to integer index value' do
      expect(@dummy.month_to_int('September')).to eq(8)
      expect(@dummy.month_to_int('March')).to eq(2)
      expect(@dummy.month_to_int('Banana')).to eq(nil)
    end
  end
end
