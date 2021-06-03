class ItemRepository
  attr_reader :all

  def initialize(path)
    @file_path = path
    @all = generate
  end

  def generate
    CSV.readlines(@file_path).drop(1).map do |line|
      id,name,description,unit_price,merchant_id,created_at,updated_at = line
      Item.new({
          :id => id.to_i,
          :name => name,
          :description => description,
          :unit_price => unit_price.to_f,
          :merchant_id => merchant_id.to_i,
          :created_at => created_at,
          :updated_at => updated_at
          })
    end
  end

  def find_by_id(id)
    @all.find do |item|
      item.id == id
    end
  end

  def find_by_name(name)
    @all.find do |item|
      item.name.downcase == name.downcase
    end
  end

  def find_all_with_description(description)
    @all.find_all do |item|
      item.description.include?(description)
    end
  end

  def find_all_by_price(price)
    @all.find_all do |item|
      item.unit_price == price
    end
  end

  def find_all_by_price_in_range(range)
    @all.find_all do |item|
      range === item.unit_price
    end
  end

  def find_all_by_merchant_id(merchant_id)
    @all.find_all do |item|
      item.merchant_id == merchant_id
    end
  end

  def new_id
    max_id = @all.max_by do |item|
      item.id
    end
    max_id.id += 1
  end

#Do we need to add this item that is created to @all?
  def create(attributes)
    Item.new({:id => new_id,
              :name => attributes[:name],
              :description => attributes[:description],
              :unit_price => attributes[:unit_price],
              :created_at => attributes[:created_at],
              :updated_at => attributes[:updated_at],
              :merchant_id => attributes[:merchant_id]
              })
  end

  def update(id, attributes)
    update_item = find_by_id(id)
    update_item.name = attributes[:name]
    update_item.description = attributes[:description]
    update_item.unit_price = attributes[:unit_price]
    update_item.updated_at = Time.now
  end

  def delete(id)
    deleted_item = find_by_id(id)
    @all.delete(deleted_item)
  end
end

# @ir.all.max_by {|item| item.id}
