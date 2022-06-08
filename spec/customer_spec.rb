require'./lib/customer'

RSpec.describe Customer do
  before :each do
    @x = Time.now
    @c = Customer.new({
      :id => 6,
      :first_name => "Joan",
      :last_name => "Clarke",
      :created_at => @x,
      :updated_at => @x
    })
      end

  it "exists" do
    expect(@c).to be_a Customer
  end

  it 'has attributes' do
    expect(@c.id).to eq(6)
    expect(@c.first_name).to eq("Joan")
    expect(@c.last_name).to eq("Clarke")
    expect(@c.created_at).to be_a Time
    expect(@c.updated_at).to be_a Time
    expect(@c.created_at).to eq @x
    expect(@c.updated_at).to eq @x
  end
end
