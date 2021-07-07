require 'pry'
require 'csv'

class MerchantRepository

  attr_reader :file_path,
              :sales_engine

  def initialize(file_path, sales_engine)
    @sales_engine = sales_engine
    @file_path    = file_path
    @id_repo       = {}
    @name_repo     = {}
  end

  def load_repo
    CSV.foreach(file_path, headers: true, header_converters: :symbol) do |row|
      binding.pry
      merchant_hash = Hash[row]
      merchant_identification = merchant_hash[:id]
      merchant_name = merchant_hash[:name]
      merchant = Merchant.new(merchant_hash, self)
      id_repo[merchant_identification] = merchant
      name_repo[merchant_name] = merchant
    end
  end



end
