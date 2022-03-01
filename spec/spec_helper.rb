# frozen_string_literal: true

require 'simplecov'
SimpleCov.start

require_relative 'merchant_spec'
require_relative 'item_spec'
require_relative 'merchant_repository_spec'
require_relative 'item_repository_spec'
require_relative 'sales_engine_spec'
require_relative 'sales_analyst_spec'
require_relative 'invoice_spec'
require_relative 'invoice_repository_spec'
require_relative 'customer_spec'
require_relative 'customer_repository_spec'
require_relative 'transaction_spec'
require_relative 'transaction_repository_spec'
