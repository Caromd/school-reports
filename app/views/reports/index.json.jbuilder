json.array!(@reports) do |report|
  json.extract! report, :id, :teacher, :teacher_comment, :principal, :principal_comment, :student_id, :term_id
  json.url report_url(report, format: :json)
end
