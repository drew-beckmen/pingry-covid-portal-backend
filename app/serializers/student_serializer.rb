class StudentSerializer < ActiveModel::Serializer
  attributes :id, :grade, :campus, :first_name, :last_name, :cohort, :veracross_id, :teacher, :email 
  has_many :isolations 
  has_many :quarantines 
  has_many :contacts 
end
