class Repository
  attr_reader :all

  def initialize
    @all = []
  end

  def add_to_repo(instance)
    @all << instance
  end

  def find_by_id(id)
    @all.find do |instance|
      instance.id == id 
    end
  end
  #create and update methods to be made
  # def create(attributes)
  #   attributes[:id] = max_id
  #   add_to_repo(Item.new(attributes))
  # end

  def delete(id)
    @all.delete(find_by_id(id))
  end
end