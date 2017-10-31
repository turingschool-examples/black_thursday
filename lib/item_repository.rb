require 'csv'

class ItemRepository

  attr_reader     :all

  def initialize
    @all = []
  end

  def populate(filename)
    contents = CSV.open (filename, headers: true,
      header_converters: :symbol)

    contents.each do |row|
      @all < Item.new(row, self)
    end
  end

  def find_by_id
  end

  def find_by_name
  end

  def find_all_with_description
  end

  def find_all_by_price
  end

  def find_all_by_price_in_range
  end

  def find_all_by_merchant_id
  end


end
