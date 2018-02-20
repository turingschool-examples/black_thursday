module Searching
  def data
    CSV.open(@file_path, headers: true, header_converters: :symbol)
  end

  def all
    data.map {|row| Merchant.new(row)}
  end

  def find_by_id(id)
    all.find {|merch| merch.id == id}
  end

  def find_by_name(name)
    all.find {|merch| merch.name.upcase == name.upcase}
  end
end
