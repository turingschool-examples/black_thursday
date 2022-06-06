require './lib/invoice_repository'
require './lib/invoice'
require 'pry'


RSpec.describe InvoiceRepository do
  before :each do
    @invoice_repository = InvoiceRepository.new("./data/invoices.csv")
  end

  it 'exists' do
    expect(@invoice_repository).to be_a InvoiceRepository
  end

  it 'returns an array of invoice instances' do
    expect(@invoice_repository.all).to be_a Array
    expect(@invoice_repository.all.count).to eq(4985)

  end

  it 'can find by id' do
    expect(@invoice_repository.find_by_id(1)).to eq(@invoice_repository.all.first)
    expect(@invoice_repository.find_by_id(4986)).to eq(nil)
    expect(@invoice_repository.find_by_id(1)).to be_a(Invoice)
  end

  it 'find all by customer id' do
    test = @invoice_repository.find_all_by_customer_id(1)

    expect(test).to be_a(Array)
    expect(test.count).to eq 8
    expect(test.first.id).to eq 1
  end

  it 'find all by merchant id' do
    test = @invoice_repository.find_all_by_merchant_id(12335938)

    expect(test).to be_a(Array)
    expect(test.count).to eq 16
    expect(test.first.id).to eq 1
  end

  it "can find all by status" do
    expect(@invoice_repository.find_by_id(1)).to eq(@invoice_repository.all.first)
    expect(@invoice_repository.find_all_by_status("pending")).to be_a(Array)
    expect(@invoice_repository.find_all_by_status("pending").first).to be_a(Invoice)
 end


 it 'can create attributes' do
   attributes =   {
        :id => 77,
        :customer_id => 7,
        :merchant_id => 12335542,
        :status => "pending",
        :created_at => Time.now,
        :updated_at => 12334105
  }

   expect(@invoice_repository.create(attributes).last.id).to eq(4986)
   expect(@invoice_repository.all.count).to eq(0)
   expect(@invoice_repository.all.last).to be_a(Invoice)
 end





end
