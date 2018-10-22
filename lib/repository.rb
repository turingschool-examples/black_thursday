class Repository

  def initialize
    @instances = []
  end

  def all
    @instances
  end

  def find_by_id(id)
    @instances.find{|instance| instance.id == id }
  end

end
