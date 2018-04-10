# Sales Engine
class SalesEngine
  attr_reader :data,
              :merchant_repo,
              :item_repo

  def initialize(data)
    @data = data
  end

  def self.from_csv(data)
    se = new(data)
    se.parse_data
    se # has access to the repos
  end

  def parse_data
    data.each do |model, file_path|
      if model == :item
        @item_repo = ItemRepository.new(file_path, self)
      elsif model == :merchant
        @merchant_repo = MerchantRepository.new(file_path, self)
      else
        nil
      end
    end
  end
end

# se = SalesEngine.from_csv(
# data = {
#   :items     => "./data/items.csv",
#   :merchants => "./data/merchants.csv",
# })
#
# mr = se.merchants
# merchant = mr.find_by_name("CJsDecor")
# # => <Merchant>
