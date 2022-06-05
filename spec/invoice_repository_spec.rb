require './lib/invoice_repository'
require './lib/sales_engine'

RSpec.describe InvoiceRepository do
  before :each do
    @sales_engine = SalesEngine.from_csv({
      :items => "./data/items.csv",
      :merchants => "./data/merchants.csv",
      :invoices => "./data/invoices.csv"
    })
    @invoice = @sales_engine.invoices
  end

  it "exists" do
    expect(@sales_engine.invoices).to be_instance_of InvoiceRepository
    expect(@invoice).to be_instance_of InvoiceRepository
  end

  it "can return an array of all Invoice instances" do

    expect(@invoice.all).to be_instance_of Array
    expect(@invoice.all.length).to eq(4985)
    expect(@invoice.all.first).to be_instance_of Invoice
    expect(@invoice.all.first.id).to eq(1)
  end
 #
  it "can find merchant by ID" do
    expect(@invoice.find_by_id(234234234)).to eq(nil)
    expect(@invoice.find_by_id(1)).to be_instance_of Invoice
  end
 #
  it "can find all by customer id" do
    expect(@invoice.find_all_by_customer_id(4)).to be_a Array
    expect(@invoice.find_all_by_customer_id(1)).to be_instance_of Invoice
  end
 #
  it "can find all by merchant id" do

    expect(@invoice.find_all_by_merchant_id(99999999)).to eq([])
    expect(@invoice.find_all_by_merchant_id(12334269)).to be_instance_of Array
    expect(@invoice.find_all_by_merchant_id(12334269).first).to be_instance_of Invoice
  end

  it "can find all by status" do
    expect(@invoice.find_all_by_status("doesnotexist")).to eq([])
    expect(@invoice.find_all_by_status("pending")).to be_instance_of Array
  end
 #
  # it "can create new merchant IDs" do
  #
  #   expect(@merchant_repository.new_id).to be_a Integer
  # end
 #
 #  it "can create new merchants" do
 #
 #    expect(@merchant_repository.create('Ducky')).to be_a Array
 #    expect(@merchant_repository.all.last.name).to eq('Ducky')
 #  end
 #
 #  it "update the Merchant instance with the corresponding id with the provided attributes" do
 #
 #    attributes = {name: "Update"}
 #
 #    @merchant_repository.update(12334105, attributes)
 #
 #    expect(@merchant_repository.find_by_id(12334105).name).to eq("Update")
 #      # expect(@merchant_repository.update(id, attributes)).to eq("Update")
 #
 # end
 #
 # it "can delete a Merchant" do
 #   @merchant_repository.delete(12334105)
 #
 #   expect(@merchant_repository.find_by_id(12334105)).to eq(nil)
 # end

end
