class ContactSerializer < ActiveModel::Serializer
    attributes :id, :exposure, :student_id, :notes, :recent_recovery
    belongs_to :student 
end
