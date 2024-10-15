json.data do
  json.companies @companies do |company|
    json.id       company.id
    json.name     company.name
  end
end
