require 'csv'

class CsvParser

  def merchants(merchants)
    contents = CSV.open merchants, headers: true, header_converters: :symbol
    id = []
    name = []
    contents.each do |row|
      id << row[:id]
      name << row[:name]
    end
    array = id.zip(name).to_h.map do |key, value|
      { :id => key, :name => value }
    end
    array
  end
  # best to refactor - zip will break with bad data - id or name missing in any row


  def items(items)
    contents = CSV.open items, headers: true, header_converters: :symbol
    arr = []
    contents.each do |row|
      item = []
      item << row[:id]
      item << row[:name]
      item << description = clean_item_description(row[:description])
      item << row[:created_at]
      item << row[:updated_at]
      item << row[:merchant_id]
      arr << item
    end
  p  arr
  end


  def clean_item_description(description)
    description.delete!("\n")
  end


end
