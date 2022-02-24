require "./spec/spec_helper"
require "./lib/test"

RSpec.describe Test do


  it "exists" do
    test = Test.new
    expect(test).to be_an_instance_of(Test)
  end

end
