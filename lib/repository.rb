class Repository
  def initialize(repo_data)
    @repo_data = repo_data
  end

  def all
    @repo_data
  end

  def find_by_id(id)
    @repo_data.find { |data| data.id == id}
  end

  def find_by_name(name)
    @repo_data.find { |data| data.name.downcase == name.downcase}
  end

  def find_all_by_name(fragment)
    @repo_data.find_all { |data| data.name.downcase.include?(fragment)}
  end

#  def update(id, attribute)
#    if attribute.keys.include?(:name) == true
#      if find_by_id(id) != nil
#        update_attribute = find_by_id(id)
#        update_attribute.name = attribute[:name]
#        update_attribute.updated_at = Time.now
#      end
#    end
#    update_attribute
#  end

  def delete(id)
    @repo_data.delete(find_by_id(id)) if find_by_id(id) != nil
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
    @repo_data.find_all {|item| item.merchant_id == merchant_id}
  end

  def find_all_by_invoice_id(invoice_id)
    @repo_data.find_all {|item| item.invoice_id == invoice_id}
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
