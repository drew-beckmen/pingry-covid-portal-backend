class IsolationSerializer < ActiveModel::Serializer
  attributes :id, :start_isolation, :date_improving, :fever_free, :end_date, :student_id, :completed, :confirmed, :notes, :potential
  belongs_to :student
end