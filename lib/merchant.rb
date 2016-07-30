class Merchant
  attr_reader :id,
              :name

  def initialize(merchant, merchant_repository_parent = nil)
    @merchant_repository_parent = merchant_repository_parent
    @id = merchant[:id].to_i
    @name = merchant[:name]
  end

  def items
    @merchant_repository_parent.find_items_by_merchant_id(id)
  end
end

#fixtures directory of sample data
#no need for setup in tests
#parser class

#downcase here
