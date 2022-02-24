require './lib/sales_engine'

RSpec.describe SalesEngine do
  it "exists" do
    se = SalesEngine.new

    expect(se).to be_a(SalesEngine)
  end
end
