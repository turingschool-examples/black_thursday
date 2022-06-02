require "./lib/merchant"
require "spec_helper"


RSpec.describe(Merchant) do
  let(:merchant) { Merchant.new({:id => 5, :name => "Turing School"}) }

  it("exists") do
    expect(merchant).to(be_a(Merchant))
  end

  it("#id") do
    expect(merchant.id).to(eq(5))
  end

  it("#name") do
    expect(merchant.name).to(eq("Turing School"))
  end
end
