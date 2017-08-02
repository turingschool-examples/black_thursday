require 'bigdecimal'
require 'bigdecimal/util'
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
    merchant = id_repo.detect do |id, merchant_instance|
      id_repo[id].name.downcase == name.downcase
    end
    if merchant.nil?
      return merchant
    else
      id_repo[merchant[0]]
    end
  end

  def find_all_by_name(name)
    id_repo.values.select do |merchant_instance|
      merchant_instance.name.downcase.include?(name.downcase)
    end
  end

  def merchant_repo_to_se(merchant_id)
    @sales_engine.items_by_merchant_id(merchant_id)
  end

  def merchant_repo_to_se_invoices(merchant_id)
    @sales_engine.invoices_by_merchant_id(merchant_id)
  end

  def merchant_repo_to_se_customers(merchant_id)
    @sales_engine.customers_by_merchant_id(merchant_id)
  end

  def merchants_by_revenue
    self.all.sort_by do |merchant|
      merchant.revenue
    end.reverse
  end

  def inspect
    "#<#{self.class} #{@merchants.size} rows>"
  end

end
