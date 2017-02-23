require 'csv'
require_relative 'repository'
require_relative 'merchant'

class MerchantRepository < Repository

  # attr_reader :path
  #
  # def initialize(path)
  #   @path = path
  #   #@merchants = {}
  #   #@all_merchants = []
  #   #@name_pieces = []
  # end

  # data = [<Merchant name: 'John Johnson', ...]
  def initialize(path)
    klass = Merchant
    super(path, Merchant)
  end

  def find_by_name(name)
    data.select {|row| row.name == name }
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


  def find_all_by_name(name_piece)
    broken_name = @merchants.keys

    broken_name.map do |name|
      if name.to_s.include?(name_piece.upcase)
          @name_pieces << name

      end
  end
    # returns either [] or one or more matches which contain the supplied name fragment, case insensitive
  end



end
