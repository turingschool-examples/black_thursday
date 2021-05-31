require 'CSV'
require_relative 'merchant'

class MerchantRepository
  attr_reader :id, :name

  def initialize(file_path)
    # @id = file_path[].to_i
    # @id = id.to_i
    create_repo(file_path)
#filepath of CSV, rather than create csv within initialize, just call additional
#helper method(create repo)
  end

  def create_repo(file_path)
      #could this be its own class?
    @merchants = Hash.new(nil)
    # @merchants = {} #info access down the road, processing speed
    #iteratres through the given CSV, allows for headers to be symbols
    #isolates each row.  each row is a hash made up of KV pairs.  Within the row,
    #headers are keys, values are what is in the row.
    #from there, we are adding a KV pair to the merchants hash where
    #the key is the ID# and the value is the merchant object
    CSV.foreach(file_path, headers: true, header_converters: :symbol) do |row|
      #key is "something", value is merchant object
      @merchants[row[:id]] = Merchant.new(row)
      # require "pry"; binding.pry
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
  #
  def find_by_id(id)
    @merchants.keys.find { |id| id } #????
    # found = []
    #
    # if @merchants.find(id) == id
    #   found << id
    # end
    # id = id.to_i
    # @merchants.select[:id]

   # @merchants.select {|merchant| merchant.id == 12335971 }
   # @merchants.select {|merchant| merchant[“id”]}

   # # require "pry";binding.pry
   # p found[0]
  end


  def find_by_name(name)
    @merchants[name]
  end

  def find_all_by_name(name)
    @merchants.keys.find_all(name)
  end

  def create(attributes)
  end

  def update(id, attributes)
  end

  def delete(id)
  end


end
