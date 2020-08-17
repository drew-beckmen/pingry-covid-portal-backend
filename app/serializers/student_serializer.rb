class StudentSerializer < ActiveModel::Serializer
  attributes :id, :grade, :campus, :first_name, :last_name 
  has_many :isolations 
  has_many :quarantines 
end
