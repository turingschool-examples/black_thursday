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
end
