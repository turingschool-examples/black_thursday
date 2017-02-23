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
    data
  end

  def find_by_name(name)
    data.select do |row|
      if row.name == name
        return row.name
      else
        return nil
      end
    end
  end

  def find_by_id(id)
    data.select do |row|
      if row.id == id
        return row.id
      else
        return nil
      end
    end
  end

  def find_all_by_name(fragment)
    data.select do |row|
      upcased = row.name.upcase
      if upcased.include?(fragment.upcase)
        return row.name
      end
    end
  end

  def inspect
     "#<#{self.class} #{@merchants.size} rows>"
  end

end
