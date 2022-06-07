module Methodable

  def find_by_id(id)
    @all.find { |invoiceitem| invoiceitem.id == id }
  end

  def update(id, attributes)
    if find_by_id(id)
      find_by_id(id).update(attributes)
    end
  end

  def inspect
    "#<#{self.class} #{@merchants.size} rows>"
  end
end
