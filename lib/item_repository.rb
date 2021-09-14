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
end