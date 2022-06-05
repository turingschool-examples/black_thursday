require './lib/customer_repository'
require './lib/customer'

RSpec.describe CustomerRepository do
  before :each do
    @sales_engine = CustomerRepository.new("./data/customers.csv")
  end

  it 'exists' do
    expect(@sales_engine).to be_a(CustomerRepository)
  end

  it "returns all known Customer instances" do
    expect(@sales_engine.all).to be_a Array
    expect(@sales_engine.all.count).to eq(1000)
  end
#
  it "can find by id" do
    expect(@sales_engine.find_by_id(1)).to eq(@sales_engine.all.first)
    expect(@sales_engine.find_by_id(8675309)).to eq(nil)
    expect(@sales_engine.find_by_id(1)).to be_a(Customer)
  end

  it "can find ALL by first name fragment" do
    fragment = "oe"
    expect(@sales_engine.find_all_by_first_name(fragment).count).to eq 8
    expect(@sales_engine.find_all_by_first_name("CHEESE")).to eq([])
    expect(@sales_engine.find_all_by_first_name(fragment)).to be_a Array
  end

  it "can find ALL by last name" do
    fragment = "On"
    expect(@sales_engine.find_all_by_last_name(fragment).length).to eq 85
    expect(@sales_engine.find_all_by_last_name("CHEESE")).to eq([])
    expect(@sales_engine.find_all_by_last_name(fragment)).to be_a Array
  end

  it 'can create Customer instance' do
    x = Time.now
    last_id_number_in_csv = @sales_engine.all.last.id.to_i
    attributes = {
      :id => nil,
      :first_name => "Joan",
      :last_name => "Clarke",
      :created_at => x,
      :updated_at => x
      }

    expect(@sales_engine.create(attributes).last.id).to eq(1001)
    expect(@sales_engine.all.last.first_name).to eq("Joan")
    expect(@sales_engine.all.last).to be_a(Customer)
    expect(@sales_engine.all.count).to eq(1001)
  end
#
  it "can update(id, attribute) on a Customer instance" do
    attributes = {
      :first_name => "Joan",
      :last_name => "Clarke"
      }

    @sales_engine.update(1, attributes)

    expect(@sales_engine.find_by_id(1).first_name).to eq("Joan")
    expect(@sales_engine.find_by_id(1).last_name).to eq("Clarke")
    expect(@sales_engine.find_by_id(1).updated_at).to be_a Time
  end

  it "can delete a customer instance" do
    expect(@sales_engine.find_by_id(1)).to be_a(Customer)
    @sales_engine.delete(1)
    expect(@sales_engine.find_by_id(1)).to eq(nil)
  end

  it "can check if invoice is paid in full" do
    expect(@sales_engine.invoice_paid_in_full?(1)).to eq true
  end
end
