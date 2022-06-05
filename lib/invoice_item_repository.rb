require 'entry'
class InvoiceItemRepository

  attr_reader :id,
              :item_id,
              :invoice_id,
              :created_at,
              :all

  attr_accessor :unit_price,
                :updated_at,
                :quantity

  def initialize(file_path)
    @file_path = file_path
    @all = []
    CSV.foreach(file_path, headers: true, header_converters: :symbol) do |row|
      @all << InvoiceItem.new(
        :id => row[:id].to_i,
        :item_id => row[:item_id],
        :invoice_id => row[:invoice_id],
        :quantity => row[:quantity],
        :unit_price => row[:unit_price],
        :created_at => row[:created_at],
        :updated_at => row[:updated_at]
        )
      end
  end

  def find_by_id(id)
    @all.find do |invoice_item|
      invoice_item.id == id
    end
  end

  def find_all_by_item_id(item_id)
    @all.find_all do |invoice_item|
      invoice_item.item_id.to_i == item_id.to_i
    end
  end

end






#
# def find_by_name(name)
#   @all.find do |merchant|
#     merchant.name.upcase == name.upcase
#   end
# end
#
# def find_all_by_name(name_fragment)
#   @all.find_all do |merchant|
#     merchant.name.upcase.include?(name_fragment.upcase)
#   end
# end
#
# def create(attributes)
#   x = (@all.last.id + 1)
#   @all << Merchant.new({
#     :id => x,
#     :name => attributes[:name]
#     })
# end
#
# def update(id, attributes)
#   x = find_by_id(id)
#   x.name = attributes[:name]
# end
#
# def delete(id)
#   x = find_by_id(id)
#   @all.delete(x)
# end
