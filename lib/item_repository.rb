require_relative 'entry'
class ItemRepository
  attr_reader :all

  def initialize(file_path)
    @file_path = file_path
    @all = []
    CSV.foreach(file_path, headers: true, header_converters: :symbol) do |row|
      @all << Item.new(
        :id => row[:id].to_i,
        :name => row[:name],
        :description => row[:description].delete("\n"),
        :unit_price => row[:unit_price].to_f,
        :created_at => row[:created_at],
        :updated_at => row[:updated_at],
        :merchant_id => row[:merchant_id].to_i
        )
    end
  end

  def inspect
    "#<#{self.class} #{@all.size} rows>"
  end

  def find_by_id(id)
    @all.find {|item| item.id == id}
  end

  def find_by_name(name)
    @all.find {|item| item.name.upcase == name.upcase}
  end

  def find_all_with_description(description_fragment)
    @all.find_all do |item|
      item.description.upcase.include?(description_fragment.upcase)
    end
  end

  def find_all_by_price(price)
    @all.find_all {|item| item.unit_price == price }
  end

  def find_all_by_price_in_range(price_range)
    @all.find_all do |item|
      item.unit_price.between? price_range.first, price_range.last
    end
  end

  def find_all_by_merchant_id(merchant_id)
    @all.find_all {|item| item.merchant_id == merchant_id }
  end

  def create(attributes)
    create_item = (@all.last.id + 1)
    @all << Item.new({
      :id => create_item,
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
    delete_item = find_by_id(id)
    @all.delete(delete_item)
  end

end
