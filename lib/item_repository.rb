class ItemRepository
  def initialize(path)
    @path = path
  end

  def to_array
    items = []

    CSV.foreach(@path, headers: true, header_converters: :symbol) do |row|
      headers = row.headers
      items << row.to_h
    end
    items
  end

  def all
    to_array.map do | item |
      Item.new(item)
    end
  end

  def find_by_id(id)
    found = false
    all.each do | item |
      if item.id == id
        return item
        found = true
      end
    end
    if found == false
      return nil
    end
  end

  def find_by_name(name)
    name.upcase!
    found = false

    all.each do | item |
      if item.name.upcase == name
        return item
        found = true
      end
    end
    if found == false
      return nil
    end
  end

  def find_all_with_description(description)
    description.upcase!

    all.find_all do | item |
      item.description.upcase.include?(description)
    end
  end

  def find_all_by_price(price)
    all.select do | item |
      item.unit_price == price
    end
  end

  def find_all_by_price_in_range(range)
    all.select do | item |
      range.first <= item.unit_price && range.last >= item.unit_price
    end
  end

  def find_all_by_merchant_id(merchant_id)
    all.select do | item |
      merchant_id == item.merchant_id
    end
  end

  def find_highest_id
    max_item = all.max_by do | item |
      item.id
    end
    max_item.id
  end

  def create(name, description, unit_price, merchant_id)
  id = find_highest_id + 1
  current_time = Time.now.utc
  CSV.open(@path, "a") do | csv |
    csv << [id.to_s, name, description, unit_price.to_s, merchant_id, current_time.to_s, current_time.to_s]
    end
  end
end
