require'./lib/customer'

RSpec.describe Customer do
  before :each do
    @time = Time.now
    @cutomer = Customer.new({
      :id => 6,
      :first_name => "Joan",
      :last_name => "Clarke",
      :created_at => @time,
      :updated_at => @time
    })
      end

  it "exists" do
    expect(@cutomer).to be_a Customer
  end

  it 'has attributes' do
    expect(@cutomer.id).to eq(6)
    expect(@cutomer.first_name).to eq("Joan")
    expect(@cutomer.last_name).to eq("Clarke")
    expect(@cutomer.created_at).to be_a Time
    expect(@cutomer.updated_at).to be_a Time
    expect(@cutomer.created_at).to eq @time
    expect(@cutomer.updated_at).to eq @time
  end
end
