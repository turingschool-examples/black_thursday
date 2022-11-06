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
    it 'converts a string representing month of the year to equal integer value' do
      expect(@dummy.month_to_int('September')).to eq(8)
      expect(@dummy.month_to_int('March')).to eq(2)
      expect(@dummy.month_to_int('Banana')).to eq(nil)
    end
  end

  describe '#same_month?' do
    it 'checks a time value against month integer value for equality' do
      expect(@dummy.same_month?(Time.parse("2012-08-26 20:56:56 UTC"), 8)).to eq(true)
      expect(@dummy.same_month?(Time.parse("2012-05-26 20:56:56 UTC"), 5)).to eq(true)
    end
  end

  describe '#convert_to_time' do
    it 'converts a string in time format to a time object' do
      expect(@dummy.convert_to_time("2012-05-26 20:56:56 UTC")).to eq(Time.parse('2012-05-26 20:56:56 UTC'))
      expect(@dummy.convert_to_time(Time.parse('2012-05-26 20:56:56 UTC'))).to eq(Time.parse('2012-05-26 20:56:56 UTC'))
    end
  end
end
