require_relative './repo_module'
require_relative './invoice'

class InvoiceRepository
  include RepoModule

  attr_reader :all

  def initialize(file_path)
    @class_name = Invoice
    @all = from_csv(file_path)
  end

  def find_all_by_customer_id(customer_id)
    @all.find_all do |object|
      object.customer_id == customer_id
    end
  end

  def find_all_by_merchant_id(merchant_id)
    @all.find_all do |object|
      object.merchant_id == merchant_id
    end
  end

  def find_all_by_status(status)
    @all.find_all do |object|
      object.status == status
    end
  end

  def create(attributes)
    highest_object = @all.max {|object| object.id}
    attributes[:id] = highest_object.id + 1
    attributes[:status] = attributes[:status]
    attributes[:customer_id] = attributes[:customer_id]
    attributes[:merchant_id] = attributes[:merchant_id]
    attributes[:created_at] = Time.new.to_s
    attributes[:updated_at] = Time.now.to_s
    @all << @class_name.new(attributes)
  end

  def update(id, attributes)
    object = find_by_id(id)
    object.status = attributes[:status] if attributes[:status]
    object.updated_at = Time.new.getutc if object
  end
end
