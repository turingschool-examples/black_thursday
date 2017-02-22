require 'csv'
require_relative 'merchant'

class MerchantRepo

  attr_reader

  def initialize
    @merchants = {}
    @all_merchants = []
  end

  def load_file(file)
    contents = CSV.open file, headers: true, header_converters: :symbol
  end

  def parse_headers(file)
    contents = load_file(file)

    contents.each do |row|
      id = row[:id]
      name = row[:name]
      # created_at = row[:created_at]
      # updated_at = row[:updated_at]
      @merchants[name.upcase] = Merchant.new(
                              { :name => name,
                                :id => id })
    end
  end

  def all
    # returns an array of all known Merchant instances
    @all_merchants << @merchants.values

  end

  def find_by_id
    # returns either nil or an instance of Merchant with a matching ID
  end



  def find_by_name(name)

    name = name.upcase
    if @merchants.has_key?(name)
      @merchants[name]
    else
      nil
    end
    # returns either nil or an instance of Merchant having done a case insensitive search
  end


  def find_all_by_name
    @merchants.keys
    # returns either [] or one or more matches which contain the supplied name fragment, case insensitive
  end



end
