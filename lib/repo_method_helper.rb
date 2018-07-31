module RepoMethodHelper

  def all
    @list
  end

  def find_by_id(id_number)
    all.find do |each|
      each.id.to_i == id_number
    end
  end

  def find_by_name(name)
    downcased_name = name.downcase
    all.find do |each|
      each.name.downcase == downcased_name
    end
  end

  def create_id
    sorted = all.sort_by do |each|
      each.id
    end
    last = sorted.last
    (last.id.to_i + 1).to_s
  end

  def find_all_by_merchant_id(merchant_id)
    all.find_all do |each|
      each.merchant_id.to_i == merchant_id
    end
  end

  def find_all_by_invoice_id(invoice_id)
    @list.find_all do |invoice_item|
      invoice_item.invoice_id == invoice_id
    end
  end

  def delete(id)
    all.delete(find_by_id(id))
  end

  def inspect
    "#<#{self.class} #{@list.size} rows>"
  end
end
