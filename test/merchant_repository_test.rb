require 'minitest/autorun'
require 'minitest/pride'
require './lib/merchant_repository.rb'
require './lib/merchant.rb'


class MerchantRepositoryTest < MiniTest::Test
  attr_reader :mr

  def setup
    @mr = MerchantRepository.new([{ :id => "12334115", :name => "LolaMarleys"}])
  end

  def test_it_initializes_with_correct_id
    assert mr
  end

  # def test_it_finds_all
  #   expected = [#<Merchant:0xXXXXXX @id="12334115", @name="LolaMarleys">]]
  #   assert_equal expected, mr.all
  # end

end
