require 'bigdecimal'
require_relative 'spec_helper'

RSpec.describe ItemRepository do

  before(:each) do
    @paths = {
      :items => "./data/items.csv",
      :invoices => "./data/invoices.csv",
      :merchants => "./data/merchants.csv"

    }
    @se = SalesEngine.from_csv(@paths)
  end

  it "exists" do
    ir = @se.items

    expect(ir).to be_a(ItemRepository)
  end

  it "calls and reads correct file path" do
    ir = @se.items
    ir_csv_data = ir.all

    expect(ir_csv_data.class).to eq(Array)
    expect(ir_csv_data.length).to eq(1367)

    data_validation = ir_csv_data.all? do |line|
      line.class == Item
    end

    expect(data_validation).to be(true)
  end

  it 'can find item by id' do
    ir = @se.items
    result = ir.find_by_id(ir.all[0].id)

    expect(result.name).to eq('510+ RealPush Icon Set')
  end

  it 'can find item by case insensitive name' do
    ir = @se.items
    result = ir.find_by_name(ir.all[0].name.upcase)

    expect(result.name).to eq('510+ RealPush Icon Set')
  end

  it 'can find all by name' do
    ir = @se.items
    result = ir.find_all_by_name('hoop'.upcase)

    expect(result.class).to eq(Array)
    expect(result.length).to eq(9)
  end

  it 'can create new instance with attributes' do
    ir = @se.items
    new_item = {
            :id => ir.create_new_id,
            :name => 'Pencil',
            :description => 'Ticonderoga',
            :unit_price => BigDecimal(2.99, 3),
            :created_at => Time.now,
            :updated_at => Time.now,
            :merchant_id => 2}

    ir.create(new_item)
    result = ir.all[-1]

    expect(result.class).to eq(Item)
    expect(result.id).to eq(new_item[:id])
    expect(result.name).to eq(new_item[:name])
    expect(result.description).to eq(new_item[:description])
    expect(result.unit_price).to eq(new_item[:unit_price] / 100) #aligns with spec harness, revisit if necessary
    expect(result.created_at).to eq(Time.parse(new_item[:created_at].to_s))
    expect(result.updated_at).to eq(Time.parse(new_item[:updated_at].to_s))
    expect(result.merchant_id).to eq(new_item[:merchant_id])
  end

  it 'can update an existing Item instance name' do
    ir = @se.items
    time_stub = '2021-05-30 11:30:51.343158 -050'
    allow(Time).to receive(:now).and_return(time_stub)
    item_update = {
                :name => 'Pen',
                :description => 'Pentel R.S.V.P. Fine' ,
                :unit_price => BigDecimal(5.99, 3)
              }

    ir.update(ir.all[0].id, item_update)
    result = ir.all[-1]

    expect(result.name).to eq(item_update[:name])
    expect(result.description).to eq(item_update[:description])
    expect(result.unit_price).to eq(item_update[:unit_price])
    expect(result.updated_at).to eq(Time.now)

  end

  it 'can delete an existing Item instance' do
    ir = @se.items

    old_length = ir.all.length
    result = ir.delete(ir.all[0].id)
    new_length = ir.all.length

    expect(old_length - new_length).to eq(1)
  end

  it 'can find all by description' do
    ir = @se.items
    result = ir.find_all_with_description('hoop'.upcase)

    expect(result.class).to eq(Array)
    expect(result.length).to eq(9)
  end

  it 'can find all by price' do
    ir = @se.items
    result = ir.find_all_by_price(BigDecimal(25))

    expect(result.class).to eq(Array)
    expect(result.length).to eq(79)
  end

  it 'can find all by price range' do
    ir = @se.items

    test_range = (0..10.0)
    result = ir.find_all_by_price_in_range(test_range)

    expect(result.class).to eq(Array)
    expect(result.length).to eq(302)
  end

  it 'can find all merchants by merchant id' do
    ir = @se.items

    result = ir.find_all_by_merchant_id(12334280)

    expect(result.class).to eq(Array)
    expect(result.length).to eq(3)
  end
end
