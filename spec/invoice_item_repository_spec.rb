require './lib/invoice_item_repository'

RSpec.describe InvoiceItemRepository do

  before :each do

    @iir = InvoiceItemRepository.new('./data/invoice_items.csv')

    @test_attributes = {
      :id => 6,
      :item_id => 7,
      :invoice_id => 8,
      :quantity => 1,
      :unit_price => BigDecimal(10.99, 4),
      :created_at => Time.now,
      :updated_at => Time.now
    }
  end

  it "exists" do
    expect(@iir).to be_a(InvoiceItemRepository)
  end

  it "has all" do
    expect(@iir.all).to be_a(Array)
    expect(@iir.all).to include(InvoiceItem)
  end

  it "has find_by_id" do
    expect(@iir.find_by_id(1)).to be_a(InvoiceItem)
    expect(@iir.find_by_id(21899)).to be_nil
  end

  it "has find_all_by_item_id" do
    expect(@iir.find_all_by_item_id(263519844)).to be_a(Array)
    expect(@iir.find_all_by_item_id(263519844).length).to eq(164)
  end

  it "has find_all_by_invoice_id" do
    expect(@iir.find_all_by_invoice_id(4985).length).to eq(1)
    expect(@iir.find_all_by_invoice_id(4985).first.quantity).to eq(4)
  end

  it "has create(attributes)" do
    expect(@iir.find_by_id(21831)).to be_nil
    @iir.create(@test_attributes)
    expect(@iir.find_by_id(21831)).to be_a(InvoiceItem)
    expect(@iir.find_by_id(21831).unit_price).to eq(10.99)
  end

  it "has update(id, attributes)" do
    @iir.create(@test_attributes)
    expect(@iir.find_by_id(21831).item_id).to eq(7)
    @iir.update(21831, {item_id: 999, quantity: 5, unit_price: BigDecimal(9.99,4)})
    expect(@iir.find_by_id(21831).quantity).to eq(5)
    expect(@iir.find_by_id(21831).item_id).to eq(7)
    @iir.update(99999, {quantity: 99})
    expect(@iir.find_by_id(99999)).to be_nil
  end

  it "has delete(id)" do
    @iir.create(@test_attributes)
    expect(@iir.find_by_id(21831).invoice_id).to eq(8)
    @iir.delete(21831)
    expect(@iir.find_by_id(21831)).to be_nil
  end

end
