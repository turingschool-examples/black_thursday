require 'pry'

require 'csv'
require_relative 'merchant'

class MerchantRepository
#
  attr_reader :file_path,
              :sales_engine,
              :id_repo,
              :name_repo
#
  def initialize(file_path, sales_engine)
    @sales_engine = sales_engine
    @file_path    = file_path
    @id_repo      = {}
    @name_repo    = {}
  end

  attr_reader :file_path,
              :sales_engine,
              :id_repo,
              :name_repo

  def initialize(file_path, sales_engine)
    @sales_engine = sales_engine
    @file_path    = file_path
    @id_repo       = {}
    @name_repo     = {}
    load_repo
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
      merchant_info
    end
  end

  def find_by_id(id)
    id_repo[id]
  end

  def find_by_name(name)
    name_repo[name]
  end

  def find_all_by_name(name)
    binding.pry
    merchants = name_repo.keys.select do |merchant_name|
      merchant_name.downcase.include?(name.downcase)
    end
    merchants
  end

  def inspect
    "#<#{self.class} #{@merchants.size} rows>"
  end

end
