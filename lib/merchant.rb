# frozen_string_literal: true

# This class holds the infromation about the merchants grabbed from the CSV
# file.
class Merchant
  def initialize(data, parent)
    @id         = data[:id].to_i
    @name       = data[:name]
    @parent     = parent
    @created_at = Date.now
    @updated_at = Date.now
  end
end
