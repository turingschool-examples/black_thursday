require_relative 'test_helper'
require './lib/repository_functions'

class RepositoryFunctionsTest < Minitest::Test
  include RepositoryFunctions
  attr_reader :variable
  def setup
    @variable = [ "Shopin1901", "Candisart", "MiniatureBikez", "LolaMarleys",
    "Keckenbauer", "GJGemology", "perlesemoi", "GoldenRayPress", "jejum",
    "Urcase17", "BowlsByChris", "MotankiDarena", "TheLilPinkBowtique", "DesignerEstore",
    "SassyStrangeArt", "byMarieinLondon", "Urcase17", "JUSTEmonsters", "Uniford",
    "thepurplepenshop", "handicraftcallery", "Madewithgitterxx", "JacquieMann",
    "TheHamAndRat", "Lnjewelscreation", "FlavienCouche", "VectorCoast",
    "BloominScents", "GJGemology", "MuttisStrickwaren", "Urcase17"]
  end


  def test_repository_functions_exists_and_is_a_module
    assert Module, RepositoryFunctions.class
  end

  def test_it_finds_by_given_element
    input = "Urcase17"
    assert_equal input, RepositoryFunctions.find_by(variable, input)
  end

  def test_it_returns_nil_if_the_element_is_not_found
    input = "BetterCallSaul"
    assert_equal nil, RepositoryFunctions.find_by(variable, input)
  end

  def test_it_finds_all_instances_of_an_element
    input = "Urcase17"
    assert_equal 3, RepositoryFunctions.find_all(variable, input).count
  end

  def test_it_returns_an_empty_array_if_none_are_found
    input = "BetterCallSaul"
    assert_equal [], RepositoryFunctions.find_all(variable, input)
  end
end
