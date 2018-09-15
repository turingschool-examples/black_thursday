require 'csv'
require 'bigdecimal'
require 'time'
require_relative './repository_module'

class TransactionRepository
  include RepoMethods

  def initialize(filepath = nil)
    @filepath = filepath
    @all = []
    #split(filepath) if filepath != nil
  end
end 
