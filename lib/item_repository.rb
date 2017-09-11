class ItemRepository

  def initialize(csv_file_name)
    CSV.foreach("#{csv_file_name}", headers: true, header_converters: :symbol) do |row|
      item = Item.new(row)
    end
  end

end
