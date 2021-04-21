require 'item'
require 'bigdecimal'

RSpec.describe Item do
  describe 'instantiation' do
    it '::new' do
      mock_repo = double("repo")
      item1 = Item.new({:id          => 1,
                        :name        => 'Pencil',
                        :description => 'You can use it to write things',
                        :unit_price  => BigDecimal(10.99,4),
                        :created_at  => Time.now,
                        :updated_at  => Time.now,
                        :merchant_id => 2}, mock_repo)

      expect(item1).to be_an_instance_of(Item)
    end

    it 'has attributes' do
      mock_repo = double("repo")
      item1 = Item.new({:id          => 1,
                        :name        => 'Pencil',
                        :description => 'You can use it to write things',
                        :unit_price  => BigDecimal(10.99,4),
                        :created_at  => Time.now,
                        :updated_at  => Time.now,
                        :merchant_id => 2}, mock_repo)
      
      expect(item1.id).to eq(1)
      expect(item1.name).to eq ('Pencil')
      expect(item1.description).to eq('You can use it to write things')
      expect(item1.unit_price).to be_an_instance_of(BigDecimal)
      expect(item1.created_at).to be_an_instance_of(Time)
      expect(item1.updated_at).to be_an_instance_of(Time)
    end
  end

  describe '#methods' do
    it '#unit price to dollars' do
      mock_repo = double("repo")
      item = Item.new({:id           => 1,
                        :name        => 'Pencil',
                        :description => 'You can use it to write things',
                        :unit_price  => 1099,
                        :created_at  => Time.now,
                        :updated_at  => Time.now,
                        :merchant_id => 2}, mock_repo)
    
      expect(item.unit_price_to_dollars).to eq(10.99)
    end

    it '#updates name if new name' do
      mock_repo = double("repo")
      item = Item.new({:id          => 1,
                       :name        => 'Pencil',
                       :description => 'You can use it to write things',
                       :unit_price  => 1099,
                       :created_at  => Time.now,
                       :updated_at  => Time.now,
                       :merchant_id => 2}, mock_repo)  
     
      item.update_name({:name => 'Knife'})
     
      expect(item.name).to eq('Knife')

      # mock_repo = double("repo")
      item2 = Item.new({:id          => 1,
                       :name        => 'Pencil',
                       :description => 'You can use it to write things',
                       :unit_price  => 1099,
                       :created_at  => Time.now,
                       :updated_at  => Time.now,
                       :merchant_id => 2}, mock_repo) 
    
      item2.update_name({:id => 1})

      expect(item2.name).to eq('Pencil')
    end

    it '#updates description if new description' do
      mock_repo = double("repo")
      item = Item.new({:id          => 1,
                        :name        => 'Pencil',
                        :description => 'You can use it to write things',
                        :unit_price  => 1099,
                        :created_at  => Time.now,
                        :updated_at  => Time.now,
                        :merchant_id => 2}, mock_repo)  
    
      item.update_description({:description => 'You can use it to stab things'})
    
      expect(item.description).to eq('You can use it to stab things')

      mock_repo = double("repo")
      item2 = Item.new({:id          => 1,
                        :name        => 'Pencil',
                        :description => 'You can use it to write things',
                        :unit_price  => 1099,
                        :created_at  => Time.now,
                        :updated_at  => Time.now,
                        :merchant_id => 2}, mock_repo) 

      item2.update_description({:id => 1})

      expect(item2.name).to eq('Pencil')
    end

    it '#updates unit price if new unit price' do
      mock_repo = double("repo")
      item = Item.new({:id          => 1,
                       :name        => 'Pencil',
                       :description => 'You can use it to write things',
                       :unit_price  => 1099,
                       :created_at  => Time.now,
                       :updated_at  => Time.now,
                       :merchant_id => 2}, mock_repo)  
      
      item.update_unit_price({:unit_price => BigDecimal(15.99, 4)})
    
      expect(item.unit_price).to eq(15.99)

      item2 = Item.new({:id          => 1,
                        :name        => 'Pencil',
                        :description => 'You can use it to write things',
                        :unit_price  => 1099,
                        :created_at  => Time.now,
                        :updated_at  => Time.now,
                        :merchant_id => 2}, mock_repo) 

      item2.update_unit_price({:id => 1})

      expect(item2.unit_price).to eq(10.99)
    end

    it '#updates updated at time' do
      mock_repo = double("repo")
      item = Item.new({:id          => 1,
                      :name        => 'Pencil',
                      :description => 'You can use it to write things',
                      :unit_price  => 1099,
                      :created_at  => Time.now,
                      :updated_at  => Time.now,
                      :merchant_id => 2}, mock_repo)  
    
      item.update_updated_at({:updated_at => Time.now})
    
      expect(item.updated_at).to be_an_instance_of(Time)
    end

    it '#updates id' do
      mock_repo = double("repo")
      item = Item.new({:id          => 1,
                       :name        => 'Pencil',
                       :description => 'You can use it to write things',
                       :unit_price  => 1099,
                       :created_at  => Time.now,
                       :updated_at  => Time.now,
                       :merchant_id => 2}, mock_repo)  
  
      new_id = 10000
  
      expect(item.update_id(10000)).to eq 10001
    end
  end
end

