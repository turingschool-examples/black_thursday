require 'rspec'
require 'pry'
require './lib/mathable'

describe Mathable do
  it "finds an average" do
    math = Mathable.new
    a = ["bugs", "mammals", "plants"]
    b = ["Monday", "Tuesday", "Wednesday", "Thursday"]
    c = [4, 5]
    d = [4, 7, 8]

    expect(math.average(a, b)).to eq(0.75)
    expect(math.average(c, d)).to eq(0.67)
  end

  it "finds standard_devation" do
    math = Mathable.new
    set = [3, 4, 5]
    expect(math.standard_devation(set)).to eq(1)
    new_set = [8, 257, 2, 17]
    expect(math.standard_devation(new_set)).to eq(124.15)
    math.method
  end

end
