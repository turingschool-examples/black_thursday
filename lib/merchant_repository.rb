require 'csv'
require_relative 'merchant'

class MerchantRepository

  def initialize(item_hash)
    @id = item_hash[:id]
    @name = item_hash[:name]
    @created_at = item_hash[:created_at]
    @updated_at = item_hash[:updated_at]
  end
  #returns an array of all known Merchant instances
  # def all
  #   ObjectSpace.each_object(MerchantRepository) {|merchant| << merchant}
  # end

  #returns either nil or an instance of Merchant with a matching ID
  def id(id_number)
    csv_text = File.read('merchants.csv')
    csv = CSV.parse(csv_text, :headers => true)
      csv.each do |row|
        puts csv.find {|row| row[id_number]}
      end
  end
  #returns either nil or an instance of Merchant having done a case insensitive search
  def find_by_name
  end

  #returns either [] or one or more matches which contain the supplied name fragment, case insensitive
  def find_all_by_name
  end

end
