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

  
end