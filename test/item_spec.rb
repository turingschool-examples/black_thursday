require './lib/item'
require './lib/merchant'

RSpec.describe Item do
  let(:i) do
    Item.new({
               id: 1,
               name: 'Pencil',
               description: 'You can use it to write things',
               unit_price: BigDecimal(10.99, 4),
               created_at: Time.now,
               updated_at: Time.now,
               merchant_id: 2
             })
  end
  it 'exists and has attributes' do
    expect(i).to be_instance_of(Item)
    expect(i.id).to eq(1)
    expect(i.name).to eq('pencil')
    expect(i.description).to eq('you can use it to write things')
    expect(i.unit_price).to eq(10.99)
    expect(i.created_at).to be_instance_of(Time)
    expect(i.updated_at).to be_instance_of(Time)
    expect(i.merchant_id).to eq(2)
  end

  it 'changes unit_price to dollars' do
    expect(i.unit_price_to_dollars).to eq(10.99)
  end

  it 'updates name, description, and unit price' do
    i.update({
      name: 'Paint Brush',
      description: 'You can use it to paint things',
      unit_price: BigDecimal(12.99, 4)
    })
    expect(i.name).to eq('paint brush')
    # expect(i.description).to eq('paint brush')
    expect(i.description).to eq('you can use it to paint things')
    expect(i.unit_price_to_dollars).to eq(12.99)
  end
end
