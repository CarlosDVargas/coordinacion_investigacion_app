class Project < ApplicationRecord
    has_many :project_investigators
    has_many :investigators, through: :project_investigators
end
