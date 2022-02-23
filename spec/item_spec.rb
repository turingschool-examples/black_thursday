require_relative '../lib/item'

RSpec.describe Item do

  context 'create Item class' do
    i = Item.new({
      :id          => 1,
      :name        => "Pencil",
      :description => "You can use it to write things",
      :unit_price  => BigDecimal.new(10.99,4),
      :created_at  => Time.now,
      :updated_at  => Time.now,
      :merchant_id => 2
    })

    it 'exists' do
      expect(i).to be_an_instance_of(Item)
    end

  end

end
