require './lib/invoice_repository'

RSpec.describe InvoiceRepository do

  before :each do

    @invoice_repository = InvoiceRepository.new('./data/invoices.csv')
    @i = Invoice.new({
      :id          => 6,
      :customer_id => 7,
      :merchant_id => 8,
      :status      => "pending",
      :created_at  => Time.now,
      :updated_at  => Time.now,
    })
    @pizza_invoice = ({
      :id          => 6,
      :customer_id => 7,
      :merchant_id => 8,
      :status      => "pending",
      :created_at  => Time.now,
      :updated_at  => Time.now,
    })

    @update = ({
      :id          => 999,
      :customer_id => 999,
      :merchant_id => 999,
      :status      => "shipped",
      :created_at  => Time.now,
      :updated_at  => Time.now,
    })
  end

  it "exists" do
    expect(@invoice_repository).to be_a(InvoiceRepository)
  end

  it "has an array of invoice instance" do
    expect(@invoice_repository.all).to be_a(Array)
    expect(@invoice_repository.all.length).to eq(4985)
    expect(@invoice_repository.all.first).to be_a(Invoice)
    expect(@invoice_repository.all.first.id).to eq(1)
  end

  it "can find_by_id" do
    expect(@invoice_repository.find_by_id(000)).to be_nil
    expect(@invoice_repository.find_by_id(1)).to be_a(Invoice)
    expect(@invoice_repository.find_by_id(1).id).to eq(1)
  end

  it "can find_all_by_customer_id" do
    expect(@invoice_repository.find_all_by_customer_id(000)).to eq([])
    expect(@invoice_repository.find_all_by_customer_id(1)).to be_a(Array)
    expect(@invoice_repository.find_all_by_customer_id(1).first).to be_a(Invoice)
    expect(@invoice_repository.find_all_by_customer_id(1).length).to eq(8)
  end

  it "can find_all_by_merchant_id" do
    expect(@invoice_repository.find_all_by_merchant_id(16510561)).to be_a(Array)
    expect(@invoice_repository.find_all_by_merchant_id(12335938).first).to be_a(Invoice)
  end

  it 'can find_all_by_status' do
    expect(@invoice_repository.find_all_by_status("pending")).to be_a(Array)
    expect(@invoice_repository.find_all_by_status("pending").first).to be_a(Invoice)
    # expect(@invoice_repository.find_all_by_status("pending")).to include(1, 4, 5, 6, 7, 10, 11, 14, 17, 23, 30, 35, 38, 41, 45, 48, 50, 54, 55, 57, 73, 78, 79, 80, 86, 87)
  end

  it "can create new invoices" do
    expect(@invoice_repository.find_by_id(4986)).to be_nil
    @invoice_repository.create(@pizza_invoice)
    expect(@invoice_repository.find_by_id(4986)).to be_a(Invoice)
  end

  it "can update the invoice instance" do
    @invoice_repository.create(@pizza_invoice)
    expect(@invoice_repository.find_by_id(4986)).to be_a(Invoice)
    @invoice_repository.update(4986, @update)
    expect(@invoice_repository.find_by_id(4986)).to be_a(Invoice)
    expect(@invoice_repository.find_by_id(4986).customer_id).to eq(7)
    expect(@invoice_repository.find_by_id(4986).status).to eq("shipped")
  end

  it "can delete invoices" do
    @invoice_repository.create(@pizza_invoice)
    expect(@invoice_repository.find_by_id(4986)).to be_a(Invoice)
    @invoice_repository.delete(4986)
    expect(@invoice_repository.find_by_id(4986)).to be_nil
  end
end
