require 'csv'

class ItemRepository

  attr_reader :items

  def initialize(csv_filepath)
    @csv_filepath = csv_filepath
    create_items(@csv_filepath)
    @items = []
  end

  def all
  end

  def find_by_id
  end

  def find_by_name
  end

  def find_all_with_description
  end

  def find_all_by_price
  end

  def find_all_by_price_in_range
  end

  def find_all_by_merchant_id
  end

# private

  def create_items(csv_filepath)
    parse_csv_data(csv_filepath)
  end

  def parse_csv_data(csv_filepath)
    contents = CSV.open(csv_filepath, headers: true, header_converters: :symbol)
    contents.each do |row|
      id = row[:id]
      name = row[:name]
      description = row[:description]
      unit_price = row[:unit_price]
      merchant_id = row[:merchant_id]
      created_at = row[:created_at]
      updated_at = row[:updated_at]
    end
  end

end
