require_relative 'repository/record'


class Customer < Repository::Record

  attr_reader :first_name, :last_name
  def initialize(repo, fields)
    super(repo, fields)
    @first_name =  fields[:first_name]
    @last_name =   fields[:last_name]
  end



  def merchants
    matching_invoices = repo.children(:invoices, id)
    matching_invoices.find_all do |record|
      record.foreign_id(record_class) == repo.children(:merchants, id)

end
