class Certificate < ApplicationRecord
    #has_many :articles
    validates :certificateNumber, presence: true, uniqueness: true
    validates :date, presence: true
end
