require "Rspec"
require_relative "../lib/invoice_item_repo"

describe InvoiceItemRepo do
  before :each do
    @iir = InvoiceItemRepo.new('./data/invoice_items.csv')
  end

  it 'is an instance of InvoiceItemRepo' do
    expect(@iir).to be_a InvoiceItemRepo
  end

  it "creates an array full of hashes from the csv" do
    expect(@iir.to_array).to be_a Array
    expect(@iir.to_array.empty?).to be false
  end

  it "#all" do
    expect(@iir.all).to be_a Array
    expect(@iir.all.empty?).to be false
    expect(@iir.all[0]).to be_a InvoiceItem
    expect(@iir.all.length).to eq 21830
  end

  it "#find_by_id" do
    expect(@iir.find_by_id(1)).to be_a InvoiceItem
    expect(@iir.find_by_id(1).quantity).to eq(5)
    expect(@iir.find_by_id(30000)).to eq nil
  end

  it "#find_all_by_item_id" do
    expect(@iir.find_all_by_item_id(-1)).to eq []
    expect(@iir.find_all_by_item_id(263519844).length).to eq(164)
  end

  it "#find_all_by_invoice_id" do
    expect(@iir.find_all_by_invoice_id(-1)).to eq([])
    expect(@iir.find_all_by_invoice_id(1).length).to eq(8)
  end

  it "#find_highest_id" do
    expect(@iir.find_highest_id).to be_a Integer
    expect(@iir.find_highest_id).to be > 21829
  end

  it "#create" do
    attributes = {
              id: '1',
         item_id: '263519844',
      invoice_id: '1',
        quantity: '5',
      unit_price: '13635',
      created_at: Time.now.utc,
      updated_at: Time.now.utc
    }

    @iir.create(attributes)

    expect(@iir.find_by_id(21831).quantity).to eq(5)
  end

  it "#update" do
    info =  {
          id: '1',
     item_id: '263519844',
  invoice_id: '1',
    quantity: '5',
  unit_price: '13635',
  created_at: Time.now.utc,
  updated_at: Time.now.utc
            }

    @iir.create(info)
    attributes = {
         quantity: '4',
         unit_price: '10000'
       }
    @iir.update(21831, attributes)
    expect(@iir.find_by_id(21831).quantity).to eq('4')
    expect(@iir.find_by_id(21831).unit_price).to eq('10000')
  end

  it "#delete" do
    info =  {
          id: '1',
     item_id: '263519844',
  invoice_id: '1',
    quantity: '5',
  unit_price: '13635',
  created_at: Time.now.utc,
  updated_at: Time.now.utc
            }
    @iir.create(info)


    expect(@iir.find_by_id(21831)).to be_a(InvoiceItem)
    @iir.delete(21831)
    expect(@iir.find_by_id(21831)).to eq nil
  end

end
