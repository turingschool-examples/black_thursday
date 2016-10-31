require_relative 'test_helper'
require './lib/repository_functions'

class RepositoryFunctionsTest < Minitest::Test
  include RepositoryFunctions

  def test_repository_functions_exists_and_is_a_module
    assert Module, RepositoryFunctions.class
  end

  def test_it_finds_by_given_elements
    variable = 

  end
end
