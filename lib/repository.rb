class Repository

  def initialize(member_class, engine, member_data)
    @member_class = member_class
    @sales_engine = engine
    @members = []
    populate(member_data)
    raise "Repository must be subclassed" if self.class == Repository
  end

  def populate(member_data)
    member_data.each do |row|
      @members << @member_class.new(self, row)
    end
  end

  def type
    (@member_class.name.downcase + 's').to_sym
  end

  def all
    @members.dup
  end

  def find_by_id(id)
    find { |member| member.id == id }
  end

  def find(&block)
    @members.find &block
  end

  def find_all(&block)
    @members.find_all &block
  end


  def children(child_type, parent_id)
    child_repo = @sales_engine.repo(child_type)
    child_repo.find_all do |member|
      member.foreign_id(type) == parent_id
    end
  end

  def parent(parent_type, parent_id)
    @sales_engine.repo(parent_type).find_by_id(parent_id)
  end


  def unused_id
    id = rand(1_000_000) while find_by_id(id)
  end

end
