require 'SimpleCov'
SimpleCov.start

require_relative '../lib/invoice_item_repository'
require_relative '../lib/invoice_item'

RSpec.describe InvoiceItemRepository do
  before(:each) do
    @iir = InvoiceItemRepository.new('./spec/fixture_files/invoice_item_fixture.csv')
  end

  it 'exists' do
    expect(@iir).to be_an_instance_of(InvoiceItemRepository)
  end

  it 'can create invoice item object' do
    expect(@iir.all[0]).to be_an_instance_of(InvoiceItem)
  end

  it 'returns a list of invoice items' do
    expect(@iir.all.length).to eq(15)
  end

  it 'can find invoice item by id' do
    expect(@iir.find_by_id(2).item_id).to eq(1)
  end

  it 'can find all invoice items by item id' do
    expect(@iir.find_all_by_item_id(5).length).to eq(2)
    expect(@iir.find_all_by_item_id(1).length).to eq(4)
  end

  it 'can find all invoice items by invoice id' do
    expect(@iir.find_all_by_invoice_id(1).length).to eq(1)
    expect(@iir.find_all_by_invoice_id(2).length).to eq(3)
  end

  it 'can create a new invoice item object' do
    new = @iir.create({
                        :item_id => 4,
                        :invoice_id => 4,
                        :quantity => 250,
                        :unit_price => 1875
                      })

    expect(@iir.all.length).to eq(16)
    expect(new.id).to eq(16)
  end

  it 'can update invoice item attributes by id' do
    data = { :quantity => 5000 }
    @iir.update(4, data)

    expect(@iir.find_by_id(4).quantity).to eq(5000)
    expect(@iir.find_by_id(4).unit_price_to_dollars).to eq(20.00)
    expect(@iir.find_by_id(4).updated_at).to_not eq(@iir.find_by_id(4).created_at)
  end

  it 'can delete invoice item by id' do
    @iir.delete(6)

    expect(@iir.all.length).to eq(14)
  end
end
