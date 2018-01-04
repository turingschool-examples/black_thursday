require "time"

class Merchant
  attr_reader :id,
              :name,
              :created_at,
              :updated_at,
              :merchant_repo

  def initialize(row, merchant_repo)
    @id            = row[:id]
    @name          = row[:name]
    @created_at    = Time.parse(row[:created_at])
    @updated_at    = Time.parse(row[:updated_at])
    @merchant_repo = merchant_repo
  end

  def items
    @merchant_repo.find_items(self.id)
  end
end
