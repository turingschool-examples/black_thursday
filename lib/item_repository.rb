class ItemRepository
  attr_reader :sales_engine, :all, :file_path

  def initialize(file_path, sales_engine)
    @file_path = file_path
    @sales_engine = sales_engine
    @all = []
  end

  def generate
    info = CSV.open("#{@file_path}", headers: true)
    info.each do |row|
      @all << Item.new(row, self)
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

  def create(attributes)
    item_id = @all.max { |item| item.id}
    attributes['id'] = item_id.id + 1
    @all << Item.new(attributes, self)
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
