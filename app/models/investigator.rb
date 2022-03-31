class Investigator < ApplicationRecord
    has_many :project_investigators
    has_many :projects, through: :project_investigators
end
