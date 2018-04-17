require_relative './item_analyst_helper'
require_relative './invoice_analyst_helper'
require_relative './merchant_analyst_helper'

# holds references to analyst helper modules
module AnalystHelper
  include ItemAnalyst
  include InvoiceAnalyst
  include MerchantAnalyst
end
