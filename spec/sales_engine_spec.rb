require './lib/sales_engine'

RSpec.describe SalesEngine do
  it 'exists' do
    x = SalesEngine.new()
    expect(x).to be_an_instance_of(SalesEngine)
  end

  it 'has attributes' do
    x = SalesEngine.new()
    expect(customer_service.name).to eq("Customer Service")
  end
