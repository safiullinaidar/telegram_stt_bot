class Message < ApplicationRecord
  SYNC_STT_LIMIT = 25
  
  validates :chat_id, :message_id, :file_id, :duration, presence: true

  def sync_stt_available?
    duration <= SYNC_STT_LIMIT
  end
end
