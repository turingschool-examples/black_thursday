require 'csv'

class SalesEngine

  attr_reader :items, :merchants

  def self.from_csv(csv_file_name)
      if csv_file_name.include?('items')
        items_repo = ItemRepository.new(csv_file_name[:items])
      elsif csv_file_name.include?('merchants')
        merchant_repo = MerchantRepository.new(csv_file_name[:merchants])
      elsif csv_file_name.include?('items') and csv_file_name.include?('merchants')
        items_repo = ItemRepository.new(csv_file_name[:items])
        merchant_repo = MerchantRepository.new(csv_file_name[:merchants])
      else
        p "Please enter valid file name."
      end
  end
end
