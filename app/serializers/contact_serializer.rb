class ContactSerializer < ActiveModel::Serializer
    attributes :id, :exposure, :student_id, :notes
    belongs_to :student 
end
