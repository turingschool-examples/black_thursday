require_relative 'merchant'
# require_relative 'sales_engine'
require_relative 'find'
# require 'pry'

class MerchantRepository
  include Find

  attr_accessor :merchants
  attr_reader :file, :sales_engine

  def initialize(file=nil, sales_engine)
    @file = file
    @merchants = []
    @sales_engine = sales_engine
  end

  def add_new(data, sales_engine)
    merchants << Merchant.new(data, sales_engine)
  end

  def load_csv_data
    all_data = get_csv_data
    all_data.map do |row|
      add_new(row, sales_engine)
    end
  end

  def get_csv_data
    CSV.open(file, headers: true, header_converters: :symbol)
  end

  def all
    @merchants
  end

  def find_by_id(id)
    find_by_num({:id => id})
  end

  def find_by_name(name)
    find_by_string({:name => name})
  end

  def find_all_by_name(partial)
    find_all_by_string_fragment({:name => partial})
  end

end
