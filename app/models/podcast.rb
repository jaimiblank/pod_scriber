class Podcast < ApplicationRecord
  has_one_attached :audio_file
end
