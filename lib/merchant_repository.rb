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
      merchant_info = Hash[row]
      merchant_identification = merchant_info[:id]
      merchant_name = merchant_info[:name]
      merchant = Merchant.new(merchant_info, self)
      @id_repo[merchant_identification.to_i] = merchant
      @name_repo[merchant_name] = merchant
    end
  end

  def all
    id_repo.map do |id, merchant_info|
      merchant_hash
    end
  end



end
