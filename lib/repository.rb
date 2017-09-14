class Repository

  def initialize(record_subclass, engine, record_data)
    raise "Repository must be subclassed" if self.class == Repository
    @record_subclass = record_subclass
    @sales_engine = engine
    @records = []
    populate(record_data)
  end

  def populate(record_data)
    record_data.each { |row| add_record(row) }
  end

  def add_record(row)
    record = @record_subclass.new(self, row)
    @records << record
    record
  end

  def type
    (@record_subclass.name.downcase + 's').to_sym
  end

  def all
    @records.dup
  end

  def find_by_id(id)
    find { |record| record.id == id }
  end

  def find(&block)
    @records.find &block
  end

  def find_all(&block)
    @records.find_all &block
  end


  def children(child_type, parent_id)
    child_repo = @sales_engine.repo(child_type)
    child_repo.find_all do |record|
      record.foreign_id(type) == parent_id
    end
  end

  def parent(parent_type, parent_id)
    @sales_engine.repo(parent_type).find_by_id(parent_id)
  end


  def unused_id
    id = rand(1_000_000) while find_by_id(id)
  end

  def inspect
    "<#{self.class.name} with #{all.length} records>"
  end

end
