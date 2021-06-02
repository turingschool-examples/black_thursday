require 'CSV'
class ItemRepository

  attr_reader :all

  def initialize(path)
    @all = []
    populate_repository(path)
  end

  def find_by_id(id)
    all.find { |item| id == item.id }
  end

  def find_by_name(name)
    all.find { |item| name.downcase == item.name.downcase }
  end

  def find_all_with_description(description)
    all.find_all { |item| description.downcase == item.description.downcase }
  end

  def find_all_by_price(price)
    all.find_all { |item| price == item.unit_price }
  end

  def find_all_by_price_in_range(range)
    all.find_all { |item| range.include?(item.unit_price) }
  end

  def find_all_by_merchant_id(merchant_id)
    all.find_all { |item| merchant_id == item.merchant_id }
  end

  def create(attributes)
    new_id = all.max_by { |item| item.id }.id + 1
    attributes[:id] = new_id
    item = Item.new(attributes)
    all << item
  end

  def update(id, attributes)
    find_by_id(id).update(attributes)
  end

  def delete(id)
    item = find_by_id(id)
    all.delete(item)
  end

  def populate_repository(path)
    CSV.foreach(path, headers: true, header_converters: :symbol) do |row|
      data_hash = {
        id: row[:id].to_i,
        name: row[:name],
        description: row[:description],
        unit_price: BigDecimal(row[:unit_price]),
        created_at: Time.parse(row[:created_at]),
        updated_at: Time.parse(row[:updated_at]),
        merchant_id: row[:merchant_id].to_i
      }
      @all << Item.new(data_hash)
    end
  end
end
