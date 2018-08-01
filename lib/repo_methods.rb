module RepoMethods

  def all
    @repo
  end

  def find_by_id(id)
    @repo.find do |object|
      object.id == id
    end
  end

  def find_by_name(name)
    @repo.find do |object|
      object.name.casecmp(name).zero? # if case-insensitive returns 0, = the same name
    end
  end

  def find_all_by_merchant_id(merchant_id)
    @repo.find_all do |object|
      object.merchant_id == merchant_id
    end
  end

  def create_id
    find_highest_id.id + 1
  end

  def find_highest_id
    @repo.max_by do |object|
      object.id
    end
  end

  def delete(id)
    object = @repo.find_index do |object|
      object.id == id
    end
    return if object.nil?
    @repo.delete_at(object)
  end

  def find_all_by_invoice_id(invoice_id)
    @repo.find_all do |invoice_item|
      invoice_item.invoice_id == invoice_id
    end
  end

  def inspect
    "#<#{self.class} #{@repo.size} rows>"
  end
end
