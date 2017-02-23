require 'csv'
require_relative 'repository'
require_relative 'merchant'

class MerchantRepository < Repository

  attr_reader :klass, :data

  def initialize(path)
    klass = Merchant
    super(path, klass)
  end


  def find_by_name(name)
    # data.select {|row| row.name == name }
    data.select do |row|
      if row.name == name
        return row.name
      else
        return nil
      end
    end
  end

  def find_by_id(id)
    # data.select {|row| row.name == name }
    data.select do |row|
      if row.id == id
        return row.id
      else
        return nil
      end
    end
  end


  end
end
    # returns either [] or one or more matches which contain the supplied name fragment, case insensitive
