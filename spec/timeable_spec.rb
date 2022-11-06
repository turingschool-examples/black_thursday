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
    it 'converts a number from day of week string' do
      expect(@dummy.convert_int_to_day(@convert1)).to eq('Tuesday')
      expect(@dummy.convert_int_to_day(@convert2)).to eq(nil)
      expect(@dummy.convert_int_to_day(@convert3)).to eq('Friday')
    end
  end
end
