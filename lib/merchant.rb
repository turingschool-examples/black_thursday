class Merchant

  attr_reader :id,
              :name,
              :merchant_repo

  def initialize(description)
    @id            = description[:id]
    @name          = description[:name]
    @merchant_repo = description[:merchant_repo]
  end

  def self.creator(row, parent)
    new({
      id: row[:id].to_i,
      name: row[:name],
      merchant_repo: parent
    })
  end

  def items
    merchant_repo.find_item(id)
  end

end
