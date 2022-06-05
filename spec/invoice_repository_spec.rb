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
    expect(@invoice.find_by_id(1).status).to eq("pending")
  end
 #
  it "can find all by customer id" do
    expect(@invoice.find_all_by_customer_id(1)).to be_a Array
    expect(@invoice.find_all_by_customer_id(1).first).to be_instance_of Invoice
    expect(@invoice.find_all_by_customer_id(1).length).to eq(8)
  end
 #
  it "can find all by merchant id" do

    expect(@invoice.find_all_by_merchant_id(99999999)).to eq([])
    expect(@invoice.find_all_by_merchant_id(12334269)).to be_instance_of Array
    expect(@invoice.find_all_by_merchant_id(12334269).length).to eq(1)
    expect(@invoice.find_all_by_merchant_id(12334269).first).to be_instance_of Invoice
  end

  it "can find all by status" do
    expect(@invoice.find_all_by_status("doesnotexist")).to eq([])
    expect(@invoice.find_all_by_status("pending")).to be_instance_of Array
  end
 #
  it "can create new invoices" do
    attributes =   {
        :id => 77,
        :customer_id => 7,
        :merchant_id => 12335550,
        :status => "pending",
        :created_at => Time.now,
        :updated_at => 12334105
  }

     expect(@invoice.create(attributes)).to be_a Array
     expect(@invoice.all.last).to be_a Invoice
     expect(@invoice.all.last.id).to eq(4986)
     expect(@invoice.all.last.customer_id).to eq(7)
  end
 #
  it " can only update the status on the invoice " do

    attributes = {status: "shipped"}

    expect(@invoice.all.first.status).to eq("pending")
    @invoice.update(1, attributes)

    expect(@invoice.all.first.status).to eq("shipped")
 end

 it "can delete an invoice" do

   expect(@invoice.all.count).to eq(4985)

   @invoice.delete(1)

   expect(@invoice.find_by_id(1)).to be_nil
   expect(@invoice.all.count).to eq(4984)
 end
end
