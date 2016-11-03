require 'csv'

module CSV_parser

  def item_csv_parse(file)
    contents = CSV.open file, headers: true, header_converters: :symbol
    contents.map do |row|
      Item.new({:id => row[:id],
                :name => row[:name],
                :unit_price => row[:unit_price],
                :created_at => row[:created_at],
                :updated_at => row[:updated_at],
                :merchant_id => row[:merchant_id],
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
      Invoice.new({ :id => row[:id],
                    :customer_id => row[:customer_id],
                    :merchant_id => row[:merchant_id],
                    :status => row[:status],
                    :created_at => row[:created_at],
                    :updated_at => row[:updated_at]
                 })
    end
  end

end