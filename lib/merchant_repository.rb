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
    data.select {|row| row.name == name }
  end


  def all
    # returns an array of all known Merchant instances
    @all_merchants << @merchants.values

  end

  def find_by_id
    # returns either nil or an instance of Merchant with a matching ID
  end



  # def find_by_name(name)
  #   name = name.upcase
  #   if @merchants.has_key?(name)
  #     @merchants[name]
  #   else
  #     nil
  #   end
  #   # returns either nil or an instance of Merchant having done a case insensitive search
  # end


  def find_all_by_name(name_piece)
    broken_name = @merchants.keys

    broken_name.map do |name|
      if name.to_s.include?(name_piece.upcase)
          @name_pieces << name
      end
    end
  end
end
    # returns either [] or one or more matches which contain the supplied name fragment, case insensitive
