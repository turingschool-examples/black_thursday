module Inspect

  def inspect
	@invoices.nil? ? nil : "#<#{self.class} #{@invoices.size} rows>"
  end

end