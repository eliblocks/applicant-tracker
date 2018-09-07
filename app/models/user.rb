class User < ApplicationRecord
  extend Devise::Models
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  validates :name, presence: true, length: { minimum: 3, maximum: 25}

  has_many :employer_relationships, foreign_key: :applicant_id, class_name: 'JobApplication'
  has_many :applicant_relationships, foreign_key: :employer_id, class_name: 'JobApplication'

  has_many :employers, through: :employer_relationships, source: :employer
  has_many :applicants, through: :applicant_relationships, source: :applicant

  scope :employer, -> { where(employer: true) }
  scope :applicant, -> { where(employer: false) }
end
