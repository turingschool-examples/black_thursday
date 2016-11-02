require 'time'
require 'csv'

module CSV_parser

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

  def merchant_csv_parse(file)
    contents = CSV.open file, headers: true, header_converters: :symbol
    contents.map do |row|
      Merchant.new({:id => row[:id].to_i, :name => row[:name]})
    end
  end

  def invoice_csv_parse(file)
    contents = CSV.open file, headers: true, header_converters: :symbol
    contents.map do |row|
      Invoice.new({ :id => row[:id].to_i,
                    :customer_id => row[:customer_id].to_i,
                    :merchant_id => row[:merchant_id].to_i,
                    :status => row[:status],
                    :created_at => Time.parse(row[:created_at]),
                    :updated_at => Time.parse(row[:updated_at])
                 })
    end
  end

end