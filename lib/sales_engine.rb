require "csv"

class SalesEngine

  # def from_csv(hash)
  #   items_file_name = hash[:item]
  #   items(items_file_name)
  #   merchants_file_name = hash[:merchants]
  # end


  def merchants
    contents = CSV.open "./data/merchants.csv", headers: true, header_converters: :symbol
    contents.each do |row|
      id = row[:id]
    end
  end

  def items
    contents = CSV.open "./data/items.csv", headers: true, header_converters: :symbol
  end

end
