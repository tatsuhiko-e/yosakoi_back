class Music < ApplicationRecord
  include Rails.application.routes.url_helpers
  has_one_attached :music_file
  validates :title, presence: { message: 'が入力されていません' },
                    length: { minimum: 1, maximum: 18 }
  validates :theme, length: { minimum: 1, maximum: 255 }
  validate  :check_audio

  def audio_url
    music_file.attached? ? url_for(music_file) : nil
  end

  belongs_to :users, optional: true
  scope :active_music, -> {where(:active => true)}


  private

  def check_audio
    if music_file.respond_to?(:content_type)
      unless music_file.content_type.in?(ALLOWED_CONTENT_TYPES)
        errors.add(:music_file, "jpg, jpeg,pngのみアップロードできます")
      end
      if music_file.byte_size > 10.megabytes
        errors.add(:music_file, "10MBまでアップロードできます")
      end
    end
  end
end
