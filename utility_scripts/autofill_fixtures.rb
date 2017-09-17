require "csv"

def plural(singular)
  singular + "s"
end

def fixture_path(plural)
  "./test/fixture/#{plural}.csv"
end

def full_data_path(plural)
  "./data/#{plural}.csv"
end

def parent_id(row, parent)
  row["#{parent}_id"]
end

def options
  { headers: true }
end

def autofill(parent, children)
  new_headers = CSV.open(full_data_path(children)).shift
  parent_ids = CSV.foreach(fixture_path(plural parent), options).map do |row|
    row["id"]
  end


  CSV.open(fixture_path(children), "wb") do |csv|
    csv << new_headers
    CSV.foreach(full_data_path(children), options) do |row|
      csv << row if parent_ids.include? parent_id(row, parent)
    end
  end
end

def autofill_reverse(parent, children)
  new_headers = CSV.open(full_data_path(plural parent)).shift
  parent_ids = CSV.foreach(fixture_path(children), options).map do |row|
    parent_id(row, parent)
  end

  CSV.open(fixture_path(plural parent), "wb") do |csv|
    csv << new_headers
    CSV.foreach(full_data_path(plural parent), options) do |row|
      csv << row if parent_ids.include? row["id"]
    end
  end
end

autofill("merchant", "items")
autofill("merchant", "invoices")
autofill("invoice", "invoice_items")
autofill("invoice", "transactions")
autofill_reverse("customer", "invoices")
