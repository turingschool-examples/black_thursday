# frozen_string_literal: true

# This object holds all of the merchants. On initialization, we feed in the
# seperated out list of merchants, which we obtained from the CSV file. For each
# row, denoted here by the merchant variable, we insantiate a new item object
# that includes a reference to it's parent. We store this list in the
# merchant_list isntance variable, allowing us to reference the list outside of
# this class. The list is stored as an array.
class MerchantRepository
  include Search
  include ChangeModule
  attr_reader :merchant_list,
              :parent
  def initialize(merchants, parent)
    @merchant_list = merchants.map { |merchant| Merchant.new(merchant, self) }
    @parent = parent
  end

  def create(attributes)
    @merchant_list << Merchant.new(attributes)
  end
end
