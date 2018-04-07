# frozen_string_literal: true

require 'simplecov'
SimpleCov.start
require 'minitest'
require 'minitest/emoji'
require 'minitest/autorun'

class MerchantRepositoryTest < MiniTest::Test
  def setup
    @m = MerchantRespository
