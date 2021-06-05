require 'SimpleCov'
SimpleCov.start

require_relative '../lib/invoice_repository'
require_relative '../lib/invoice'

RSpec.describe InvoiceRepository do
  before :each do
    @ir = InvoiceRepository.new('./spec/fixture_files/invoice_fixture.csv')
  end

  it 'exists' do
    expect(@ir).to be_an_instance_of(InvoiceRepository)
  end

  it 'can create invoice objects' do
    expect(@ir.all.length).to eq(5)
    expect(@ir.all[0]).to be_an_instance_of(Invoice)
  end

  it 'can find invoice by ID' do
    expect(@ir.find_by_id(1)).to eq(@ir.all[0])
    expect(@ir.find_by_id(2)).to eq(@ir.all[1])
  end

  it 'finds an invoice by name' do
    expect(@ir.find_all_by_customer_id(1)).to eq([@ir.all[0], @ir.all[1]])
    expect(@ir.find_all_by_customer_id(2)).to eq([@ir.all[2]])
    expect(@ir.find_all_by_customer_id(4)).to eq([])
  end

  xit 'finds invoice by description' do
    ir = ItemRepository.new('./spec/fixture_files/item_fixture.csv')
    expected = ir.find_all_with_description('You can use it to write things')
    expected2 = ir.find_all_with_description('Help me')

    expect(expected.length).to eq(3)
    expect(expected2.length).to eq(0)
  end

  xit 'finds all instances of an invoice by price' do
    ir = ItemRepository.new('./spec/fixture_files/item_fixture.csv')
    price = BigDecimal(10)
    price2 = BigDecimal(12)
    price3 = BigDecimal(15)

    expected = ir.find_all_by_price(price)
    expected2 = ir.find_all_by_price(price2)
    expected3 = ir.find_all_by_price(price3)

    expect(expected.length).to eq(1)
    expect(expected2.length).to eq(2)
    expect(expected3.length).to eq(0)
  end

  xit 'can find all instances in price range' do
    ir = ItemRepository.new('./spec/fixture_files/item_fixture.csv')
    expected = ir.find_all_by_price_in_range(8..15)
    expected2 = ir.find_all_by_price_in_range(0..7)
    expected3 = ir.find_all_by_price_in_range(16.00..25.00)

    expect(expected.length).to eq(3)
    expect(expected2.length).to eq(0)
    expect(expected3.length).to eq(1)
  end

  xit 'finds all instances based on merchant ID' do
    ir = ItemRepository.new('./spec/fixture_files/item_fixture.csv')
    expected = ir.find_all_by_merchant_id(6)
    expected2 = ir.find_all_by_merchant_id(9)
    expected3 = ir.find_all_by_merchant_id(7)


    expect(expected.length).to eq(1)
    expect(expected2.length).to eq(0)
    expect(expected3.length).to eq(3)
  end

  xit 'creates a new instance with attributes' do
    ir = ItemRepository.new('./spec/fixture_files/item_fixture.csv')
    expected = ir.create({
      :name        => 'Golden Fountain Pen',
      :description => 'You can write REALLY fancy things',
      :unit_price  => 12009,
      :merchant_id => 4
    })

    expect(ir.all.length).to eq(6)
    expect(expected.id).to eq(6)
  end

  xit 'finds invoice by ID and update attributes' do
    ir = ItemRepository.new('./spec/fixture_files/item_fixture.csv')
    data = {
      :description => 'You can write REALLY fancy things',
      :unit_price  => BigDecimal(379.99, 5)
    }
    ir.update(3, data)
    expected = ir.find_by_id(3)

    expect(expected.name).to eq('Marker')
    expect(expected.description).to eq('You can write REALLY fancy things')
    expect(expected.unit_price_to_dollars).to eq(379.99)
  end

  xit 'finds and deletes invoice by ID' do
    ir = ItemRepository.new('./spec/fixture_files/item_fixture.csv')

    ir.delete(2)
    expect(ir.all.length).to eq(4)
  end
end
