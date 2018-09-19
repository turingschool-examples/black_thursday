require 'CSV'
require_relative 'repo_module'

class TransactoinRepository
  include RepoModule

  attr_reader :repo
  def initialize(file_path)
    @repo = []
    load_items(file_path)
  end

  def load_items(file_path)
    CSV.foreach(file_path, headers: true, header_converters: :symbol) do |row|
      @repo << Transaction.new(row)
    end
  end

  def find_all_by_invoice_id(id)
    @repo.find_all do |transaction|
      transaction.invoice_id == id
    end
  end

  def create(attributes)
    attributes[:id] = @repo[-1].id + 1
    @repo << Transaction.new(attributes)
  end

  def update(id, attributes)
    transaction = find_by_id(id)
    transaction.credit_card_number = attributes[:credit_card_number] unless attributes[:credit_card_number].nil?
    transaction.credit_card_expiration_date = attributes[:credit_card_expiration_date] unless attributes[:credit_card_expiration_date].nil?
    transaction.result = attributes[:result] unless attributes[:result].nil?
    transaction.updated_at = Time.now unless (attributes[:credit_card_number].nil? && attributes[:credit_card_expiration_date].nil? && attributes[:result].nil?)
  end

  def find_all_by_credit_card_number(card_number)
    @repo.find_all do |transaction|
      transaction.credit_card_number == card_number
    end
  end

  def find_all_by_result(status)
    @repo.find_all do |transaction|
      transaction.result == status
    end
  end

end
