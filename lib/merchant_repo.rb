require 'csv'

class MerchantRepo

  attr_reader

  def initialize

  end

  def load_file(file)
    contents = CSV.open file, headers: true, header_converters: :symbol

  end

  def parse_headers(file)
    contents = load_file(file)

    contents.each do |row|
      id = row[:id]
      name = row[:name]
      created_at = row[:created_at]
      updated_at = row[:updated_at]
      require "pry"; binding.pry
    end

  end

  def all
    # returns an array of all known Merchant instances

  end

  def find_by_id
    # returns either nil or an instance of Merchant with a matching ID
  end



  def find_by_name
    # returns either nil or an instance of Merchant having done a case insensitive search
  end


  def find_all_by_name
    # returns either [] or one or more matches which contain the supplied name fragment, case insensitive
  end



end
