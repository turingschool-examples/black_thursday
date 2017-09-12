require 'csv'

module CsvParser

  def parse_data(file_name)
    CSV.open file_name, headers: true, header_converters: :symbol
  end

  def item_parse_data(file_name)
    contents = CSV.open file_name, headers: true, header_converters: :symbol

    contents.each do |row|
      @items << Item.new(
        {name: row[:name],
        description: row[:description],
        unit_price: row[:unit_price],
        created_at: row[:created_at],
        updated_at: row[:updated_at]})
    end
  end

end
