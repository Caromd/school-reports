json.array!(@enrollments) do |enrollment|
  json.extract! enrollment, :id, :student_id, :subject_id, :schoolyear_id
  json.url enrollment_url(enrollment, format: :json)
end
