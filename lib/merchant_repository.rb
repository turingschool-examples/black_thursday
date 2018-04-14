require 'CSV'

class MerchantRepository
  attr_reader :contents,
              :parent

  def initialize(path, parent = nil)
    @contents = {}
    @parent = parent
    load_path(path)
  end

  def load_path(path)
    CSV.foreach(path, headers: true, header_converters: :symbol) do |row|
      @contents[row[:id]] = Merchant.new(row, self)
      # binding.pry
    end
  end

  def all
    @contents.values
  end

  def find_by_id(id)
    @contents[id]
  end

  def find_by_name(name)
    all.find { |row| row.name.downcase == name.downcase }
  end

  def find_all_by_name(name)
    all.find_all { |row| row.downcase == name.downcase }
  end
end
