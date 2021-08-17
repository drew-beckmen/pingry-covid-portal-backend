class Student < ApplicationRecord
    has_many :quarantines
    has_many :isolations
    has_many :contacts
end
