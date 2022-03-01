require_relative 'transaction'
require_relative 'module'

class TransactionRepository
  include IDManager

  attr_reader :all
  def initialize(transactions)
    @all = transactions
  end

  def find_all_by_id(id_search)
    @all.find_all{|index| index[:id].to_s.include?(id_search.to_s)}
  end
end
