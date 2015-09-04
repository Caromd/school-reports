json.array!(@results) do |result|
  json.extract! result, :id, :classmark, :testmark, :enrollment_id, :term_id
  json.url result_url(result, format: :json)
end
