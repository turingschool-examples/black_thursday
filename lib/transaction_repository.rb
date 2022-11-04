require_relative 'transaction'

require_relative 'repo_module'

class TransactionRepository
  include RepoModule
  def inspect
    "#<#{self.class} #{@transactions.size} rows>"
  end
  attr_reader 
  def initialize()
  end
end