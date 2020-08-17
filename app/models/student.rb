class Student < ApplicationRecord
    has_many :quarantines
    has_many :isolations
end
