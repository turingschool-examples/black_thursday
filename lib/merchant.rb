require './lib/merchant_repository'

class Merchant
  attr_reader  :merchant

  def initialize(line)
    @line     = line
    @merchant = { "id" => id, "name" => name }
  end

  def id
    @line[:id]
  end

  def name
    @line[:name]
  end

end

puts MerchantRepository.new.find_all_by_name("ime")
