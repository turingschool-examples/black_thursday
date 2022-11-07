require_relative 'make_time'
require_relative 'repository'

class InvoiceItemRepository < Repository
  include MakeTime

end