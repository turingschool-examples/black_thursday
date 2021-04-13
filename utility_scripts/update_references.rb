# frozen_string_literal: true

require 'pry'
require 'csv'
require 'pry'

at_exit do
  error = $ERROR_INFO
  binding.pry if error
end

files_with_merchant_ids = %w[data/invoices.csv]
files_with_item_ids     = %w[data/invoice_items.csv]

def rows_from(csv_filename)
  File.open csv_filename, 'rb' do |f|
    CSV f, headers: true, header_converters: :symbol, &:to_a
  end
end

def write(csv_filename, rows)
  File.open csv_filename, 'wb' do |file|
    CSV file do |csv|
      csv << rows[0].headers
      rows.map { |row| csv << row.to_a.map(&:last) }
    end
  end
end

merchant_ids = rows_from('data/merchants.csv').map { |row| row[:id] }
item_ids     = rows_from('data/items.csv').map { |row| row[:id] }

files_with_merchant_ids.each do |filename|
  rows = rows_from(filename).each { |row| row[:merchant_id] = merchant_ids.sample }
  write filename, rows
end

files_with_item_ids.each do |filename|
  rows = rows_from(filename).each { |row| row[:item_id] = item_ids.sample }
  write filename, rows
end
