class Merchant

  attr_reader :id,
              :name,
              :merchant_repo

  def initialize(description)
    @id            = description[:id]
    @name          = description[:name]
    @merchant_repo = description[:merchant_repo]
  end

  def items
    merchant_repo.find_item(id)
  end

  def invoices
    merchant_repo.find_invoice(id)
  end 

end
