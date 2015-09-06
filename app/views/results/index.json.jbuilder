json.array!(@results) do |result|
  json.extract! result, :id, :classmark, :testmark, :student_id, :subject_id, :term_id
  json.url result_url(result, format: :json)
end
