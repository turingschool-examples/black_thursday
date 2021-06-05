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

  def new_id
    item_with_max_id = @repo.all.max_by do |item|
      item.id
    end
    item_with_max_id.id + 1
  end

  def create(attributes, new_id)
    new_item = Item.make_item(attributes, new_id)
    @all << new_item
  end
#Do we need to add this item that is created to @all?
  # def create(attributes)
  #   new_item = Item.new(attributes, self)
  #   new_id = new_item.id
  #   @all << new_id
  # end

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
