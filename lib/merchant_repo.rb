require_relative "./lib/merchant"
require_relative "./lib/sales_engine"

class MerchantRepo
  attr_reader :merchants,
              :parent

  def initialize(parent, filename)
    @merchants    = []
    @sales_engine = parent
    load_file(filename)
  end

  def load_file(filename)
    merchant_csv = CSV.open filename,
                            headers: true,
                            header_converters: :symbol,
                            converters: :numeric
    merchant_csv.each do |row| @merchants << Merchant.new(row, self)
    end
  end
end
