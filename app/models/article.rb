class Article < ApplicationRecord
    has_one :certificates
    validates :articleNumber, presence: true, uniqueness: true
    validates :certificateNumber, presence: true
    validates :researchCode, presence: true, length: { minimum: 0, maximum: 12 }
end
