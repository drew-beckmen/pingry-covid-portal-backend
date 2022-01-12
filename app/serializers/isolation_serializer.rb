class IsolationSerializer < ActiveModel::Serializer
  attributes :id, :start_isolation, :fever_free, :end_date, :student_id, :completed, :confirmed, :notes, :potential, :barcode
  belongs_to :student
end