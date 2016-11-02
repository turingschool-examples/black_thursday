require 'csv'
require 'time'

module ParseCSV

  def merchant_csv_parse(file)
    contents = CSV.open file, headers: true, header_converters: :symbol
    contents.map do |row|
      Merchant.new({:id => row[:id].to_i, :name => row[:name]})
    end
  end

  def item_csv_parse(file)
    contents = CSV.open file, headers: true, header_converters: :symbol
    contents.map do |row|
      Item.new({:id => row[:id].to_i,
                :name => row[:name],
                :unit_price => BigDecimal(row[:unit_price]) / 100,
                :created_at => Time.parse(row[:created_at]),
                :updated_at => Time.parse(row[:updated_at]),
                :merchant_id => row[:merchant_id].to_i,
                :description => row[:description]
              })
    end
  end

end