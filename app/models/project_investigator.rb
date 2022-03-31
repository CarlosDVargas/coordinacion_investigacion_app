class ProjectInvestigator < ApplicationRecord
    enum role: [:main, :associated]

    after_initialize :set_default_role, :if => :new_record?

    belongs_to :project
    belongs_to :investigator

    def set_default_role
        self.role ||= :associated
    end
end