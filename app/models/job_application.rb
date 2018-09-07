class JobApplication < ApplicationRecord
  belongs_to :applicant, foreign_key: 'applicant_id', class_name: 'User'
  belongs_to :employer, foreign_key: 'employer_id', class_name: 'User'
end
