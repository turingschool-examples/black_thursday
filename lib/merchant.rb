class Merchant
  attr_reader  :id,
               :name

  def initialize(hash, mr)
    @id   = hash[:id].to_i
    @name = hash[:name]
    @mr = mr
  end

  def items
    @mr.items_in_merch_repo(id)
  end

  def invoices
    @mr.invoices_in_merch_repo(id)
  end

end
