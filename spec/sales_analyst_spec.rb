require './lib/sales_analyst'

RSpec.describe SalesAnalyst do
  it 'exists' do
    sa = SalesAnalyst.new
    expect(sa).to be_an_instance_of(SalesAnalyst)
  end
end
