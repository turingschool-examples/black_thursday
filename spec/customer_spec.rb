require'./lib/customer'

RSpec.describe Customer do
  before :each do
    @x = Time.now
    @c = Customer.new({
      :id => 6,
      :first_name => "Joan",
      :last_name => "Clarke",
      :created_at => Time.now,
      :updated_at => Time.now
    })
      end

  it "exists" do
    expect(@c).to be_a Customer
  end

  # it 'has attributes' do
  #   expect(@c.id).to eq(6)
  #   expect(@c.invoice_id).to eq(8)
  #   expect(@c.credit_card_number).to eq("4242424242424242")
  #   expect(@c.credit_card_expiration_date).to eq("0220")
  #   expect(@c.result).to eq("success")
  #   expect(@c.created_at).to be_a Time
  #   expect(@c.updated_at).to be_a Time
  #   expect(@c.created_at).to eq @x
  #   expect(@c.updated_at).to eq @x
  # end
end
