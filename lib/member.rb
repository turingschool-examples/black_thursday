class Member

  attr_reader :id, :repo
  def initialize(repo, fields)
    apply_defaults(fields)
    @repo = repo
  end

  def foreign_id(type)
    type_singular = type.to_s[0..-2]
    key = type_singular + '_id'
    send(key.to_sym)
  end

  def apply_defaults(fields)
    fields[:id]         ||= repo.unused_id
    fields[:created_at] ||= Time.now
    fields[:updated_at] ||= Time.now
  end

  def ==(other)
    @id == other.id
  end

end
