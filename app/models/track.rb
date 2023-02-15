class Track < ApplicationRecord
    belongs_to :album
    has_many :notes, dependent: :destroy
end
