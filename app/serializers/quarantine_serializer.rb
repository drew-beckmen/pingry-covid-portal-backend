class QuarantineSerializer < ActiveModel::Serializer
  attributes :id, :exposure, :student_id, :completed, :notes
  belongs_to :student 
end
