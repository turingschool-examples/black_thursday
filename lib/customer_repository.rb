require_relative './reposable'
require_relative './customer'

class CustomerRepository
  include Reposable

  attr_accessor :all

  def initialize(all = [])
    @all = all
  end



end