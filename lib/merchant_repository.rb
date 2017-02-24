require 'csv'
require_relative 'repository'
require_relative 'merchant'

class MerchantRepository < Repository

  attr_reader :klass, :data

  def initialize(path)
    klass = Merchant
    super(path, klass)
  end

  def all
    @data
  end

  def find_by_name(name)
    data.select {|item| item.name.downcase == name.downcase }.first
  end

  def find_by_id(id)
    data.select {|item| item.id == id }.first
  end

  def find_all_by_name(fragment)
    data.find_all {|item| /#{Regexp.quote(fragment)}/ =~ item.name.downcase }
  end

  def inspect
     "#<#{self.class} #{@merchants.size} rows>"
  end

end
