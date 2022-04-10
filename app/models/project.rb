class Project < ApplicationRecord
    has_many :project_investigators, dependent: :destroy
    accepts_nested_attributes_for :project_investigators, allow_destroy: true
    has_many :investigators, through: :project_investigators
end
