class Repository

  def initialize(engine, members)
    @sales_engine = engine
    @members = members
    raise "Repository must be subclassed" if self.class == Repository
  end


  def all
    @members.dup
  end

  def find_by_id(id)
    find {|member|member.id == id }
  end

  def find &block
    @members.find &block
  end

  def find_all &block
    @members.find_all &block
  end

end
