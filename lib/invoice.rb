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
    @_transactions ||= @invoice_repo.engine.transactions.find_all_by_invoice_id(@id)
  end

  def paid?
    _transactions.any? { |transaction| transaction.result == :success }
  end

  def _invoice_items
    @_invoice_items ||= @invoice_repo.engine.invoice_items.find_all_by_invoice_id(@id)
  end

  def total
    _invoice_items.sum { |invoice_item| invoice_item.unit_price * invoice_item.quantity }
  end

  # def paid_on?(date)
  #   if date.is_a? String
  #     date_time = Time.parse(date)
  #   else
  #     date_time = date
  #   end
  #   _transactions.any? do |transaction|
  #     transaction.result == :success && (
  #       transaction.created_at.strftime('%d/%m/%Y') == date_time.strftime('%d/%m/%Y')
  #     )
  #   end
  # end
end
