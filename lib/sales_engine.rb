require 'csv'

class SalesEngine
  attr_reader :items_array, :merchants_array

  def from_csv(csv_files)
    csv_files.each do |name, file_path|
      case name
      when :items
        create_items(file_path)
      when :merchants
        create_merchants(file_path)
      end
    end
  end

  def create_items(file_path)
    @items_array = parse_csv(file_path, Item)
  end

  def create_merchants(file_path)
    @merchants_array = parse_csv(file_path, Merchant)
  end

  def parse_csv(file_path, klass)
    array = []
    CSV.foreach(file_path, headers: true, header_converters: :symbol) do |row|
      array << klass.new(row.to_hash)
    end
    array
  end

  def merchants

  end

  def items

  end
end