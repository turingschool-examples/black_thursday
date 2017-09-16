require 'csv'

options = { headers: true, header_converters: :symbol }
merchant_ids = CSV.foreach('./test/fixture/merchants.csv', options).map do |row|
  row[:id]
end

CSV.open('./test/fixture/invoices.csv', 'w') do |csv|
  CSV.foreach('./data/invoices.csv', options) do |row|
    csv << row if merchant_ids.include? row[:merchant_id]
  end
end
