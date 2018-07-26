require_relative 'transaction'
require_relative 'repository_assistant'

class TransactionRepository
  include RepositoryAssistant

  def initialize(data_file)
    @repository = data_file.map {|item| Transaction.new(item)}
  end

  def find_all_by_credit_card_number(card_number)
    @repository.find_all do |transaction|
      transaction.credit_card_number == card_number
    end
  end

  def find_all_by_result(result)
    @repository.find_all do |transaction|
      transaction.result.downcase.include?(result.downcase)
    end
  end

  def create(attributes)
    attributes[:id] = create_new_id_number
    @repository << Transaction.new(attributes)
  end

  def inspect
    "#<#{self.class} #{@transactions.size} rows>"
  end
end
