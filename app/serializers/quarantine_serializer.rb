class QuarantineSerializer < ActiveModel::Serializer
  attributes :id, :exposure, :student_id, :completed, :notes, :converted_to_isolation, :end_date
  belongs_to :student 
end
