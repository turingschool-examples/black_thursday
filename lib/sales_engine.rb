require 'csv'

class SalesEngine

  attr_reader :items, :merchants

  def self.from_csv(csv_file_name)
    CSV.foreach("#{csv_file_name}", headers: true, header_converter: :symbol) do |row|
      if csv_file_name.includes?('items')
        item = Item.new(row)
      elsif csv_file_name.includes?('merchants')
        merchant = Merchant.new(row)
      else
        p "Please enter valid file name."
      end
    end
  end
end
