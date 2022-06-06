class Certificate < ApplicationRecord
    has_many :articles, foreign_key: 'certificateNumber', class_name: 'Article', dependent: :destroy
    validates :certificateNumber, presence: true, uniqueness: true
    validates :date, presence: true
end
