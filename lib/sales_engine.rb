require 'pry'
require 'csv'

class SalesEngine
  def from_csv(hash)
    se_hash = Hash.new
    item_database = CSV.new hash[:items], headers: true, header_converters: :symbol
    merchant_database = CSV.new hash[:merchants], headers: true, header_converters: :symbol
    to_hash(item_database)
    to_hash(merchant_database)
    se_hash = {:items => to_hash(item_database), :merchants => to_hash(merchant_database)}
  end

  def to_hash(csv)
    csv.each do |row|
      id = row[:id]
      name = row[:name]
      created_at = row[:created_at]
      updated_at = row[:updated_at]
      # if csv == :items
      #   description = row[:description]
      #   unit_price = row[:unit_price]
      #   merchant_id = row[:merchant_id]
      # end
    end
  end

end
