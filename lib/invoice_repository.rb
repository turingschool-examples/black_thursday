# frozen_string_literal: true

require_relative './invoice'
require_relative './repository_helper'

# Invoice repository class
class InvoiceRepository
  include RepositoryHelper

  def update(id, params)
    return nil unless @repository.key?(id)
    invoice = find_by_id(id)
    invoice.status = params[:status] unless params[:status].nil?
    invoice.updated_at = Time.now
  end

  def find_all_by_customer_id(id)
    all.find_all do |invoice|
      invoice.customer_id == id
    end
  end

  def find_all_by_status(status)
    all.find_all do |invoice|
      invoice.status == status
    end
  end

  private

  def sub_class
    Invoice
  end
end
