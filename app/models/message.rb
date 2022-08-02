class Message < ApplicationRecord
  SYNC_STT_LIMIT = 25
  
  has_one_attached :voice_file
  
  validates :chat_id, :message_id, :file_id, :duration, presence: true

  def sync_stt_available?
    duration <= SYNC_STT_LIMIT
  end

  def tmp_file_name
    "#{chat_id}_#{message_id}.ogg"
  end
end
