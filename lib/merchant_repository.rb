require 'CSV'
require '/Users/bfl3tch/turing/mod_1/black_thursday/lib/merchant.rb'

class MerchantRepository

  def initialize(file_path)
    create_repo(file_path)
#filepath of CSV, rather than create csv within initialize, just call additional
#helper method(create repo)
  end

  def create_repo(file_path)
      #could this be its own class?
    @merchants = {} #info access down the road, processing speed
    #iteratres through the given CSV, allows for headers to be symbols
    #isolates each row.  each row is a hash made up of KV pairs.  Within the row,
    #headers are keys, values are what is in the row.
    #from there, we are adding a KV pair to the merchants hash where
    #the key is the ID# and the value is the merchant object
    CSV.foreach(file_path, headers: true, header_converters: :symbol) do |row|
      #key is "something", value is merchant object
      @merchants[row[:id]] = Merchant.new(row)
      #instantiating a merchant object
    end

  end

  def inspect
    # override inspect method is written in spec_harness
    #if you stick with the ruby way it causes issues
    #grabbed this code from the error message itself
    "#<#{self.class} #{@merchants.size} rows>"
  end

  def all
    #expecting instances of merchants
    @merchants
  end

  def find_by_id(id)
  end

  def find_by_name(name)
  end

  def find_alL_by_name(name)
  end

  def create(attributes)
  end

  def update(id, attributes)
  end

  def delete(id)
  end


end
