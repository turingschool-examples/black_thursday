module Repoable

  def delete(id)
    @all.delete(find_by_id(id))
  end
  #
  # def find_all_by_merchant_id(merchant_id)
  #   @all.find_all {|item| merchant_id == item.merchant_id }
  # end

  def find_by_id(id)
    @all.find { |transaction| transaction.id.to_i == id}
  end

  def inspect
      "#<#{self.class} #{@all.size} rows>"
  end









end
