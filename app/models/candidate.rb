class Candidate < ApplicationRecord
  has_one :user, as: :profile

  validates_presence_of :first_name, :last_name

  validates_inclusion_of :is_active, :can_relocate, :can_remote, :is_visa_needed, in: [true, false]

  validates_length_of :first_name, maximum: 50
  validates_length_of :last_name, maximum: 70
  validates_length_of :title, maximum: 100, allow_blank: true
  validates_length_of :address, maximum: 100, allow_blank: true
  validates_length_of :city, maximum: 50, allow_blank: true
  validates_length_of :state, maximum: 2, allow_blank: true
  validates_length_of :zip, is: 5, allow_blank: true
  validates_length_of :description, maximum: 250, allow_blank: true
  validates_length_of :minimum_salary, maximum: 8, allow_blank: true
  validates_length_of :linkedin, maximum: 50, allow_blank: true
  validates_length_of :github, maximum: 50, allow_blank: true
end
