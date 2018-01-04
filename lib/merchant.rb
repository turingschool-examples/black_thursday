class Merchant

  attr_reader :id,
              :name,
              :merchant_repo

  def initialize(description)
    @id   = description[:id]
    @name = description[:name]
    @merchant_repo = description[:merchant_repo]
  end

  def items
    merchant_repo.se.item_repository.items.find_all do |item|
      id == item.merchant_id
    end
  end

end
