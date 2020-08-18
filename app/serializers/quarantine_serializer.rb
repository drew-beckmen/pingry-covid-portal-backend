class QuarantineSerializer < ActiveModel::Serializer
  attributes :id, :exposure, :student_id, :completed
  belongs_to :student 
end
