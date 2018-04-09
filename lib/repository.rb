# Shared methods for searching repository classes
class Repository

  # def klass
  #   @types = {
  #     MerchantRepository: merchants,
  #     ItemRepository: items
  #   }
  # end

  def create_index(data_type, attributes)
    data = {}
    attributes.each do |attribute_set|
      data[attribute_set[:id]] = data_type.new(attribute_set)
    end
    data
  end

  def all
    if self == MerchantRepository
      @merchants.values
    else
      @items.values
    end
  end

  # def find_by_id(id)
  # end
end
