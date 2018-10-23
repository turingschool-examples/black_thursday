require_relative 'test_helper.rb'
require 'pry'


class MerchantRepositoryTest < Minitest::Test
  def setup
    @mr = MerchantRepository.new()
  end

  def test_it_exists
    assert_instance_of MerchantRepository, @mr
  end


end
