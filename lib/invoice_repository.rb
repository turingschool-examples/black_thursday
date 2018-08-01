require 'csv'
require_relative '../lib/invoice.rb'
require_relative '../lib/repo_method_helper.rb'
require 'pry'

class InvoiceRepository
  attr_reader :list
  include RepoMethodHelper

  def initialize(list)
    @list = list
  end

  def find_all_by_customer_id(customer_id)
    all.find_all do |each|
      each.customer_id == customer_id
    end
  end

  def find_all_by_status(status)
    all.find_all do |each|
      each.status == status.to_sym
    end
  end

  def create(attributes)
    @list << Invoice.new({
      id: create_id,
      created_at: Time.now.to_s,
      updated_at: Time.now.to_s,
      customer_id: attributes[:customer_id],
      merchant_id: attributes[:merchant_id],
      status: attributes[:status]
      })
  end

  def update(id, attributes)
    find_by_id(id).status = attributes[:status] unless attributes[:status].nil?
    find_by_id(id).updated_at = Time.now unless find_by_id(id).nil?
  end
end
