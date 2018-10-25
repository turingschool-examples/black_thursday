require 'csv'
require_relative './time_conversions'

module CSVReader
  def self.parse_merchants(mr, file_path)
    skip_first_line = true
    CSV.foreach(file_path) do |row|
      unless skip_first_line
        mr.add_merchant(Merchant.new({:id => row[0].to_i, :name => row[1]}))
      else
        skip_first_line = false
      end
    end
    mr
  end

  def self.parse_items(ir, file_path)
    skip_first_line = true
    CSV.foreach(file_path) do |row|
      unless skip_first_line
        ir.add_item(Item.new({:id => row[0].to_i, :name => row[1],
              :description => row[2], :unit_price => (BigDecimal.new(row[3],4)/100),
              :created_at => TimeConversions.to_time(row[5]),
              :updated_at => TimeConversions.to_time(row[6]),
              :merchant_id => row[4].to_i}))
      else
        skip_first_line = false
      end
    end
    ir
  end

end
