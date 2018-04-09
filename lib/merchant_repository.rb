
# Merchant Repository Class
class MerchantRepository
  # include Repository

  attr_reader :merchants,
              :parent

  def initialize(merchants, parent = nil)
    @merchants =  merchants
    @parent = parent
  end


  # def all
  #   load_children
  # end
end

# def find_by_name(name)
# end
#
# def find_all_by_name(name)
# end
#
# def create(attributes)
# end
#
# def update(id, attributes)
# end
#
# def delete(id)
# end
