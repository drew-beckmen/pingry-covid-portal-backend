class StudentSerializer < ActiveModel::Serializer
  attributes :id, :grade, :campus, :first_name, :last_name, :cohort, :veracross_id
  has_many :isolations 
  has_many :quarantines 
end
