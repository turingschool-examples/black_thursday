class Merchant
  attr_reader   :id,
                :name,
                :created_at,
                :updated_at,
                :parent

  def initialize(info, merchant_repository = "")
    @id = info[:id]
    @name = info[:name]
    @created_at = info[:created_at]
    @updated_at = info[:updated_at]
    @parent = merchant_repository
<<<<<<< HEAD
=======
  end

  def items
    @parent.items.items.values
  end

  def downcaser
    @name.downcase
>>>>>>> 28a84fc0132a30d77497ab852e7eee71d0464c86
  end

  def items
    @parent.items
  end

  def downcaser
    @name.downcase
  end
  
end
