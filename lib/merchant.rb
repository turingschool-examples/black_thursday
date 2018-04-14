# frozen_string_literal: true

# merchant repo
class Merchant
  attr_reader :id,
              :name,
              :created_at,
              :updated_at,
              :parent

  def initialize(data, parent)
    @id         = data[:id].to_i
    @name       = data[:name]
    @created_at = data[:created_at]
    @updated_at = data[:updated_at]
    @parent     = parent
  end

  def change_name(name)
    @name = name
  end

  def change_updated_at
    @updated_at = Time.now
  end

  def items
    @parent.pass_item_id_to_sales_engine(@id)
  end
end
