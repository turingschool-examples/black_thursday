class Repository

  def initialize(sales_engine, record_data)
    raise "Repository must be subclassed" if self.class == Repository
    @sales_engine = sales_engine
    @records = make_records(record_data)
  end

  def make_records(record_data)
    record_data.map { |data| make_record(data) }
  end

  def make_record(data)
    record_class.new(self, data)
  end

  def insert(data)
    record = make_record(data)
    @records << record
    record
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
      record.foreign_id(record_class) == parent_id
    end
  end

  def parent(parent_type, parent_id)
    @sales_engine.repo(parent_type).find_by_id(parent_id)
  end


  def unused_id
    id = rand(1_000_000) until find_by_id(id).nil?
  end

  def inspect
    "<#{self.class.name} with #{all.length} #{record_class.plural}>"
  end

end
