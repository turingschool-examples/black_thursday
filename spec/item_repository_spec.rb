require 'bigdecimal'
require_relative 'spec_helper'

RSpec.describe ItemRepository do
  it "exists" do
    se = SalesEngine.new
    ir = ItemRepository.new(se.library[:items])

    expect(ir).to be_a(ItemRepository)
  end

  it "calls and reads correct file path" do
    se = SalesEngine.new
    ir = ItemRepository.new(se.library[:items])
    ir_csv_data = ir.all

    expect(ir_csv_data.class).to eq(Array)
    expect(ir_csv_data.length).to eq(1367)
    # require 'pry'; binding.pry
    data_validation = ir_csv_data.all? do |line|
      line.class == Hash
      line.keys.length == 7
      line.values.length == 7
    end

    expect(data_validation).to be(true)
  end

  it 'can find item by id' do
    se = SalesEngine.new
    ir = ItemRepository.new(se.library[:items])
    result = ir.find_by_id(ir.all[0]['id'])

    expect(result['name']).to eq('510+ RealPush Icon Set')
  end

  it 'can find item by case insensitive name' do
    se = SalesEngine.new
    ir = ItemRepository.new(se.library[:items])
    result = ir.find_by_name(ir.all[0]['name'].upcase)

    expect(result['name']).to eq('510+ RealPush Icon Set')
  end

  it 'can find all by name' do
    se = SalesEngine.new
    ir = ItemRepository.new(se.library[:items])
    result = ir.find_all_by_name('hoop'.upcase)

    expect(result.class).to eq(Array)
    expect(result.length).to eq(9)
  end

  it 'can create new instance with attributes' do
    se = SalesEngine.new
    ir = ItemRepository.new(se.library[:items])
    new_item = {
            :id => ir.create_new_id,
            :name => 'Pencil',
            :description => 'Ticonderoga',
            :unit_price => BigDecimal.new(2.99, 3),
            :created_at => Time.now,
            :updated_at => Time.now,
            :merchant_id => 2}
    result = ir.create(new_item)

    expect(result.class).to eq(Item)
    expect(result.id).to eq(new_item[:id])
    expect(result.name).to eq(new_item[:name])
    expect(result.description).to eq(new_item[:description])
    expect(result.unit_price).to eq(new_item[:unit_price])
    expect(result.created_at).to eq(new_item[:created_at])
    expect(result.updated_at).to eq(new_item[:updated_at])
    expect(result.merchant_id).to eq(new_item[:merchant_id])
  end

  it 'can update an existing Item instance name' do
    se = SalesEngine.new
    ir = ItemRepository.new(se.library[:items])
    item_update = {
                :name => 'Pen',
                :description => 'Pentel R.S.V.P. Fine' ,
                :unit_price => BigDecimal.new(5.99, 3)
              }

    result = ir.update(ir.all[0]['id'], item_update)

    expect(result['name']).to eq(item_update[:name])
    expect(result['description']).to eq(item_update[:description])
    expect(result['unit_price']).to eq(item_update[:unit_price])
  end

  it 'can delete an existing Item instance' do
    se = SalesEngine.new
    ir = ItemRepository.new(se.library[:items])

    old_length = ir.all.length
    result = ir.delete(ir.all[0]['id'])
    new_length = ir.all.length

    expect(old_length - new_length).to eq(1)
  end
end
