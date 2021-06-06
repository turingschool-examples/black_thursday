class ItemRepository
  attr_reader :sales_engine, :all, :file_path

  def initialize(file_path, sales_engine)
    @file_path = file_path
    @sales_engine = sales_engine
    @all = generate
  end

  def generate
    info = CSV.open(@file_path.to_s, headers: true, header_converters: :symbol)
    info.map do |row|
      Item.new(row, self)
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
      item.description.downcase.include?(description.downcase)
    end
  end

  def find_all_by_price(price)
    @all.find_all do |item|
      item.unit_price == price
    end
  end

  def find_all_by_price_in_range(range)
    @all.find_all do |item|
      range.include? item.unit_price
    end
  end

  def find_all_by_merchant_id(merchant_id)
    @all.find_all do |item|
      item.merchant_id == merchant_id
    end
  end

  def create(attributes)
    attributes[:id] = @all.last.id + 1
    @all << Item.new(attributes, self)
  end

  def update(id, attributes)
    item = find_by_id(id)
    return nil if item.nil?

    item.update_item(attributes)
  end

  def delete(id)
    deleted_item = find_by_id(id)
    @all.delete(deleted_item)
  end

  def inspect
    "#<#{self.class} #{@all.size} rows>"
  end
end
