class WorkDay < ApplicationRecord
  belongs_to :user
  has_many :appointments, dependent: :destroy
end