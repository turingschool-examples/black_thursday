class SalesEngine

  def self.from_csv (path_string)
    csv_array = CSV.read(path_string, headers: true, header_converters: :symbol)
    item_object_array = []
    csv_array.each do |line|
      item = Item.new({ id: line[:id], name: line[:name], description: line[:description], merchant_id: line[:merchant_id], created_at: line[:created_at], updated_at: line[:updated_at] })
      item_object_array << item
    end
    self.new(item_object_array)
  end

end
