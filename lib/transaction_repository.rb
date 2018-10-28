require_relative './transaction'
require_relative './repo_module'

class TransactionRepository
  include RepoModule

  attr_reader :all
  def initialize(file_path)
    @class_name = Transaction
    @all = from_csv(file_path)
  end

  def find_all_by_invoice_id(invoice_id)

  end

  def find_all_by_credit_card_number(credit_card_number)

  end

  def find_all_by_result()

  end
end
