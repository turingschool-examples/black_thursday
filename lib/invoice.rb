# frozen_string_literal: true

require 'timeable'

# Invoice data class, can update status and time updated.
class Invoice
  include Timeable
  attr_reader :id,
              :customer_id,
              :merchant_id,
              :status,
              :created_time,
              :updated_time

  def initialize(data, repo)
    @id          = data[:id].to_i
    @customer_id = data[:customer_id].to_i
    @merchant_id = data[:merchant_id].to_i
    @status      = data[:status].to_sym
    @created_time  = data[:created_at]
    @updated_time  = data[:updated_at]
    @invoice_repo = repo
  end

  def update(attributes)
    @status = attributes[:status]
    @updated_time = Time.now
  end

  def _transactions
    @_transactions ||= @invoice_repo.send_to_engine(destination: 'transactions', method: :find_all_by_invoice_id, args: @id)
  end

  def paid?
    _transactions.any? { |transaction| transaction.result == :success }
  end

  def _invoice_items
    @_invoice_items ||= @invoice_repo.send_to_engine(method: :find_all_by_invoice_id, destination: 'invoice_items', args: @id)
  end

  def total
    _invoice_items.sum { |invoice_item| invoice_item.unit_price * invoice_item.quantity }
  end
end
