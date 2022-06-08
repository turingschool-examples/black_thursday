module Repoable

  def delete(id)
    @all.delete(find_by_id(id))
  end

  def find_all_by_merchant_id(merchant_id)
    @all.find_all {|item| merchant_id == item.merchant_id }
  end

  def find_all_by_invoice_id(invoice_id)
    @all.find_all { |invoice_item| invoice_item.invoice_id == invoice_id}
  end

  def find_by_id(id)
    @all.find { |transaction| transaction.id.to_i == id}
  end

  def find_by_name(item_name)
    @all.find {|item| item.name.downcase == item_name.downcase}
  end

  def inspect
    "#<#{self.class} #{@all.size} rows>"
  end
end
