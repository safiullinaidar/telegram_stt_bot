class YandexSttJob < ApplicationJob
  queue_as :default

  def perform(message_id)
    message = Message.find(message_id)

    file_path = Telegram::DownloadFile.call(message)

    if message.sync_stt_available?
      recognized_text = Yandex::SyncStt.call(file_path)

      message.update!(recognized_text: recognized_text)

      Telegram::SendMessage.call(message.chat_id, recognized_text, reply_to: message.message_id)
    end

    FileUtils.rm(file_path)
  end
end
