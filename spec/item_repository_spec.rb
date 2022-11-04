require 'rspec'
require_relative '../lib/item_repository'

describe ItemRepository do
  describe '#initialize' do
    it 'exists' do
      ir = ItemRepository.new

      expect(ir).to be_a(ItemRepository)
    end

    it 'starts with empty items array' do
      ir = ItemRepository.new

      expect(ir.items).to eq []
    end
  end

  describe '#all' do
    it 'returns all known instances' do
      ir = ItemRepository.new
      i = Item.new({
        :id          => 1,
        :name        => "Pencil",
        :description => "You can use it to write things",
        :unit_price  => BigDecimal(10.99,4),
        :created_at  => Time.now.to_s,
        :updated_at  => Time.now.to_s,
        :merchant_id => 2
      })

      ir.items << i

      expect(ir.all).to eq([i])
    end
  end

  describe '#find_by_id' do
    it 'can find all items by id' do
      ir = ItemRepository.new
      i1 = Item.new({
        :id          => 1,
        :name        => "Pencil",
        :description => "You can use it to write things",
        :unit_price  => BigDecimal(10.99,4),
        :created_at  => Time.now.to_s,
        :updated_at  => Time.now.to_s,
        :merchant_id => 2
      })

      i2 = Item.new({
        :id          => 2,
        :name        => "Pen",
        :description => "You can use it to write things",
        :unit_price  => BigDecimal(15.99,4),
        :created_at  => Time.now.to_s,
        :updated_at  => Time.now.to_s,
        :merchant_id => 3
      })


      ir.items << i1
      ir.items << i2

      expect(ir.find_by_id(1)).to eq i1
      expect(ir.find_by_id(2)).to eq i2
      expect(ir.find_by_id(3)).to eq nil
    end
  end

  describe '#find_by_name' do
    it 'find an item by its name' do
      ir = ItemRepository.new
      i1 = Item.new({
        :id          => 1,
        :name        => "Pencil",
        :description => "You can use it to write things",
        :unit_price  => BigDecimal(10.99,4),
        :created_at  => Time.now.to_s,
        :updated_at  => Time.now.to_s,
        :merchant_id => 2
      })

      i2 = Item.new({
        :id          => 2,
        :name        => "Pen",
        :description => "You can use it to write things",
        :unit_price  => BigDecimal(15.99,4),
        :created_at  => Time.now.to_s,
        :updated_at  => Time.now.to_s,
        :merchant_id => 3
      })

      ir.items << i1
      ir.items << i2

      expect(ir.find_by_name("Pencil")).to eq i1
      expect(ir.find_by_name("Pen")).to eq i2
      expect(ir.find_by_name("Paper")).to eq nil
    end

    it 'does not care about case sensitivity' do
      ir = ItemRepository.new
      i1 = Item.new({
        :id          => 1,
        :name        => "Pencil",
        :description => "You can use it to write things",
        :unit_price  => BigDecimal(10.99,4),
        :created_at  => Time.now.to_s,
        :updated_at  => Time.now.to_s,
        :merchant_id => 2
      })

      ir.items << i1

      expect(ir.find_by_name("pencil")).to eq i1
    end
  end

  describe '#find_all_with_description' do
    it 'can find an item by its description case insensitive' do
      ir = ItemRepository.new
      i1 = Item.new({
        :id          => 1,
        :name        => "Pencil",
        :description => "You can use it to write things",
        :unit_price  => BigDecimal(10.99,4),
        :created_at  => Time.now.to_s,
        :updated_at  => Time.now.to_s,
        :merchant_id => 2
      })

      i2 = Item.new({
        :id          => 2,
        :name        => "Pen",
        :description => "You can use it to write things",
        :unit_price  => BigDecimal(15.99,4),
        :created_at  => Time.now.to_s,
        :updated_at  => Time.now.to_s,
        :merchant_id => 3
      })

      ir.items << i1
      ir.items << i2

      expect(ir.find_all_with_description("you can use it to Write things")).to eq([i1, i2])
      expect(ir.find_all_with_description("It is unbreakable")).to eq([])
    end
  end

  describe '#find_all_by_price' do
    it 'can find items by price' do
      ir = ItemRepository.new
      i1 = Item.new({
        :id          => 1,
        :name        => "Pencil",
        :description => "You can use it to write things",
        :unit_price  => BigDecimal(10.99,4),
        :created_at  => Time.now.to_s,
        :updated_at  => Time.now.to_s,
        :merchant_id => 2
      })

      i2 = Item.new({
        :id          => 2,
        :name        => "Pen",
        :description => "You can use it to write things",
        :unit_price  => (10.99),
        :created_at  => Time.now.to_s,
        :updated_at  => Time.now.to_s,
        :merchant_id => 3
      })

      ir.items << i1
      ir.items << i2
      # require 'pry' ; binding.pry

      expect(ir.find_all_by_price(12.99)).to eq []
      expect(ir.find_all_by_price(0.1099e0)).to eq [i1, i2]
    end
  end

  describe '#find_all_by_price_in_range' do
    it 'can find items within the price range' do
      ir = ItemRepository.new
      i1 = Item.new({
        :id          => 1,
        :name        => "Pencil",
        :description => "You can use it to write things",
        :unit_price  => '1099',
        :created_at  => Time.now.to_s,
        :updated_at  => Time.now.to_s,
        :merchant_id => 2
      })

      i2 = Item.new({
        :id          => 2,
        :name        => "Pen",
        :description => "You can use it to write things",
        :unit_price  => '1525',
        :created_at  => Time.now.to_s,
        :updated_at  => Time.now.to_s,
        :merchant_id => 3
      })

      ir.items << i1
      ir.items << i2

      expect(ir.find_all_by_price_in_range((10..20))).to eq [i1, i2]
      expect(ir.find_all_by_price_in_range((10..11))).to eq [i1]
      expect(ir.find_all_by_price_in_range((10..10.5))).to eq []
    end
  end

  describe '#find_all_by_merchant_id' do
    it 'can find all items by merchant id' do
      ir = ItemRepository.new
      i1 = Item.new({
        :id          => 1,
        :name        => "Pencil",
        :description => "You can use it to write things",
        :unit_price  => BigDecimal(10.99,4),
        :created_at  => Time.now.to_s,
        :updated_at  => Time.now.to_s,
        :merchant_id => 2
      })

      i2 = Item.new({
        :id          => 2,
        :name        => "Pen",
        :description => "You can use it to write things",
        :unit_price  => BigDecimal(15.25,4),
        :created_at  => Time.now.to_s,
        :updated_at  => Time.now.to_s,
        :merchant_id => 2
      })

      ir.items << i1
      ir.items << i2

      expect(ir.find_all_by_merchant_id(2)).to eq [i1, i2]
      expect(ir.find_all_by_merchant_id(3)).to eq []
    end
  end

  describe '#create' do
    it 'can create a new item' do
      ir = ItemRepository.new
      i1 = Item.new({
        :id          => 1,
        :name        => "Pen",
        :description => "You can use it to write things",
        :unit_price  => BigDecimal(15.25,4),
        :created_at  => Time.now.to_s,
        :updated_at  => Time.now.to_s,
        :merchant_id => 2
      })
      i2 = Item.new({
        :id          => 2,
        :name        => "Pencil",
        :description => "You can use it to write things",
        :unit_price  => BigDecimal(15.25,4),
        :created_at  => Time.now.to_s,
        :updated_at  => Time.now.to_s,
        :merchant_id => 2
      })
      ir.items << i1
      ir.items << i2

      new_item = ir.create({
        :id          => 7,
        :name        => "Pen",
        :description => "You can use it to write things",
        :unit_price  => BigDecimal(15.25,4),
        :created_at  => Time.now.to_s,
        :updated_at  => Time.now.to_s,
        :merchant_id => 2
      })

      expect(new_item).to be_a(Item)
      expect(new_item.id).to eq(3)
    end
  end

  describe '#update' do
    it 'can update an items name, description, and unit price' do
      ir = ItemRepository.new
      i1 = Item.new({
        :id          => 1,
        :name        => "Pen",
        :description => "You can use it to write things",
        :unit_price  => BigDecimal(15.25,4),
        :created_at  => Time.now.to_s,
        :updated_at  => old_time = Time.now.to_s,
        :merchant_id => 2
      })
      ir.items << i1

      ir.update(1,{
                    name: "Apple",
                    description: "You can eat it",
                    unit_price: BigDecimal(20.25,4)
                    }) 

      expect(ir.all[0].name).to eq "Apple"
      expect(i1.description).to eq "You can eat it"
      expect(i1.unit_price).to eq BigDecimal(20.25,4)
      expect(i1.updated_at).not_to eq old_time
    end
  end

  describe '#delete' do
    it 'can delete an item' do
      ir = ItemRepository.new
      i1 = Item.new({
        :id          => 1,
        :name        => "Pen",
        :description => "You can use it to write things",
        :unit_price  => BigDecimal(15.25,4),
        :created_at  => Time.now.to_s,
        :updated_at  => Time.now.to_s,
        :merchant_id => 2
                    })
      ir.items << i1

      ir.delete(1)

      expect(ir.items).to eq []
    end
  end

  it 'can load data' do
    ir = ItemRepository.new
    file = './data/items.csv'
    ir.load_data(file)

    expect(ir.all.first).to be_a(Item)
    expect(ir.all.all?(Item)).to eq(true)
  end
end
