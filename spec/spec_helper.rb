# frozen_string_literal: true

require 'simplecov'
SimpleCov.start

# require_relative "test_goes_here"
require_relative 'merchant_spec'
require_relative 'invoice_item_spec'
require_relative 'merchant_repository_spec'
require_relative 'invoice_item_repository_spec'
require_relative 'sales_engine_spec'
require_relative 'general_spec'
require_relative 'item_spec'
require_relative 'customer_spec'
require_relative 'customer_repo_spec'
require_relative 'invoice_spec'
require_relative 'invoice_repo_spec'
require_relative 'transaction_spec'
require_relative 'transaction_repo_spec'
require_relative 'calculable_spec'
require_relative 'item_repository_spec'
