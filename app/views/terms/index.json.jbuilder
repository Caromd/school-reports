json.array!(@terms) do |term|
  json.extract! term, :id, :term, :startdate, :enddate, :schoolyear_id
  json.url term_url(term, format: :json)
end
