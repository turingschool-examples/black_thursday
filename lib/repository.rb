module Repository
  def all
    @repository
  end

  def find_by_id(id)
    all.find { |object| object.id == id }
  end

  def find_all_by_invoice_id(invoice_id)
    all.find_all { |object| object.invoice_id == invoice_id }
  end

  def new_highest_id
    (all.max_by { |object| object.id }).id + 1
  end

  def delete(id)
    object = find_by_id(id)
    @repository.delete(object)
  end

  def inspect
    "#{self.class} #{all.size} rows"
  end
end
