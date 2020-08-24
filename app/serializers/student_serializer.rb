class StudentSerializer < ActiveModel::Serializer
  attributes :id, :grade, :campus, :first_name, :last_name, :cohort, :veracross_id, :teacher 
  has_many :isolations 
  has_many :quarantines 
end
