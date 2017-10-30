require "CSV"
class MerchantRepository
  attr_reader :merchants,
              :parent

  def initialize(merchants, parent = "")
    @merchants = load_csv(merchants).map { |row| Merchant.new(row, self) }
    @parent    = parent
  end

  def load_csv(filename)
    CSV.open filename, headers: true, header_converters: :symbol
  end

  # def rows_from(csv_filename)
  #   File.open csv_filename, "rb" do |f|
  #     CSV f, headers: true, header_converters: :symbol do |csv|
  #       csv.to_a
  #     end
  #   end
  # end

  def all
    @merchants
  end
end
