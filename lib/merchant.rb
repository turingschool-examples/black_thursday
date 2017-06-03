require_relative '../lib/merchant_repository'

class Merchant
  attr_reader :id,
              :name,
              :merch_repo

  def initialize(merchant_data, merch_repo)
  @id = merchant_data[:id]
  @name = merchant_data[:name]
  @merch_repo = merch_repo
  end

  def items
    @merch_repo.item_output(self.id)
  end
end
