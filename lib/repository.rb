class Repository
  def initialize(repo_data)
    @repo_data = repo_data
  end

  def all
    @repo_data
  end

  def find_by_id(id)
    @repo_data.find do |data|
      data.id == id
    end
  end

  def find_by_name(name)
    @repo_data.find do |data|
      data.name.casecmp?(name)
    end
  end

  def find_all_by_name(name)
    @repo_data.find_all do |data|
      data_downcase = data.name.downcase
      data_downcase.include?(name.downcase)
    end
  end

  def update(id, attributes)
    data = find_by_id(id)
    return unless data
    attributes.each do |key, value|
      data.send("#{key}=", value) if data.respond_to?("#{key}=")
    end
    data.updated_at = Time.now
    data
  end

  def delete(id)
    data = find_by_id(id)
    @repo_data.delete(data)
  end

  def find_all_by_date(date)
    date = Date.parse(date) if date.class != Date
    @repo_data.find_all do |data|
      data.created_at.to_date == date
    end
  end

  def find_all_by_customer_id(customer_id)
    @repo_data.find_all do |data|
      data.customer_id == customer_id
    end
  end

  def find_all_by_merchant_id(merchant_id)
    @repo_data.find_all do |data|
      data.merchant_id == merchant_id
    end
  end

  def find_all_by_invoice_id(invoice_id)
    @repo_data.find_all do |data|
      data.invoice_id == invoice_id
    end
  end

  def find_all_by_item_id(item_id)
    @repo_data.find_all do |data|
      data.item_id == item_id
    end
  end

  def inspect
    "#<#{self.class} #{@repo_data.size} rows>"
  end

  private

  def find_last_id
    repo_data = @repo_data.sort_by do |data|
      data.id.to_i
    end
    data = repo_data.last
    data.id
  end
end
