require_relative "../lib/sales_engine"
require_relative "../lib/merchant"
require "csv"

class MerchantRepository
attr_reader :all

  def initialize(csv,sales_engine)
    @sales_engine = sales_engine
    @all = []
    @path = csv
    csv_loader
    merchant_maker
  end

  # def csv?
  #   @csv.is_a?(CSV)
  # end
  def csv_loader
    @csv = CSV.open @path, headers:true, header_converters: :symbols
  end

  def merchant_maker
    @csv.each do |row|
       @all << Merchant.new(row, self)
    end
  end
  def find_by_id(input)
    @all.find do |instance|
      instance.id == input
    end
  end

end
