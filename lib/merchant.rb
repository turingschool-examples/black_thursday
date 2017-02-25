# require_relative "../lib/sales_engine"

class Merchant
  attr_reader :id, :name, :repo

  def initialize(row, repo)
    @id = row[:id].to_i
    @name = row[:name]
    @repo = repo
  end

  def items
    repo.sales_engine.items.find_all_by_merchant_id(self.id)
  end

end
