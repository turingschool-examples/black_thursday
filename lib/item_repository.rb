require_relative './item'

class ItemRepository

  attr_reader :all

  def initialize
    @all = []
  end

  def populate_items(line)
    return false if line == "id,name,description,unit_price,merchant_id,created_at,updated_at\n"
    columns = line.split(",")
      id = columns[0]
      merchant_id = columns[4]
      name = columns[1]
      description = columns[2]
      unit_price = columns[3]
      created_at = columns[5]
      updated_at = columns[6]
    self.all << Item.new({ :id => id,
                               :merchant_id => merchant_id,
                               :name => name,
                               :description => description,
                               :unit_price => unit_price,
                               :created_at => created_at,
                               :updated_at => updated_at })
  end

  def find_by_id(id)
    @all.find do |item|
      if item.id == id
        return item
      end
      nil
    end
  end

  def find_by_name(name)
    @all.find do |item|
      if item.name.downcase == name.downcase
        return item
      end
      nil
    end
  end

  def find_all_with_description(description)
    result = []
    @all.find_all do |item|
      if item.description.downcase == description.downcase
        result << item
      end
    end
    result
  end

  def find_all_by_price(unit_price)
    result = []
    @all.find_all do |item|
      if item.unit_price == unit_price
        result << item
      end
    end
    result
  end

  def find_all_by_price_in_range(range)
    result = []
    @all.each do |item|
      if range.include? item.unit_price
        result << item
      end
    end
    result
  end

  def find_all_by_merchant_id(merchant_id)
    result = []
    @all.find_all do |item|
      if item.merchant_id == merchant_id
        result << item
      end
    end
    result
  end

end
