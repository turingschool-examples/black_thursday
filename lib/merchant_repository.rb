require 'pry'
require './lib/merchant_repository'
# require './lib/ItemRepository'
require 'csv'

class MerchantRepository

  attr_reader :file_path,
              :sales_engine,
              :id_repo,
              :name_repo

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

  # all - returns an array of all known Merchant instances

  def all
    id_repo.map do |id, merchant_info|
      merchant_hash
    end
  end

  # find_by_id - returns either nil or an instance of Merchant with a matching ID

  def find_by_id(id)
    id_repo[id]
  end
  # find_by_name - returns either nil or an instance of Merchant having done a case insensitive search
  # find_all_by_name - returns either [] or one or more matches which contain the supplied name fragment, case insensitive



end
