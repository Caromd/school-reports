json.array!(@students) do |student|
  json.extract! student, :id, :firstname, :surname, :dob
  json.url student_url(student, format: :json)
end
