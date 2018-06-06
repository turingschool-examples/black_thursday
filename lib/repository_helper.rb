module RepositoryHelper
  def all
    @repository
  end

  def find_by_id(id)
    @repository.find { |instance| instance.id == id }
  end

  def find_by_name(name)
    @repository.find { |instance| instance.name.casecmp(name).zero? }
  end

  def find_all_by_merchant_id(merchant_id)
    @repository.select { |instance| instance.merchant_id == merchant_id }
  end

  def find_all_by_invoice_id(invoice_id)
    @repository.select { |instance| instance.invoice_id == invoice_id }
  end

  def delete(id)
    instance = find_by_id(id)
    @repository.delete(instance)
  end
end
