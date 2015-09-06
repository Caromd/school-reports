json.array!(@terms) do |term|
  json.extract! term, :id, :year, :term, :startdate, :enddate
  json.url term_url(term, format: :json)
end
