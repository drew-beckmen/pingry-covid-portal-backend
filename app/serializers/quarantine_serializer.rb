class QuarantineSerializer < ActiveModel::Serializer
  attributes :id, :exposure, :student_id 
  belongs_to :student 
end
