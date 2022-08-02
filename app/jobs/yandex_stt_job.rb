class YandexSttJob < ApplicationJob
  queue_as :default

  def perform(message_id)
    message = Message.find(message_id)

    file_path = Telegram::DownloadFile.call(message)

    if message.sync_stt_available?
      recognized_text = Yandex::SyncStt.call(file_path)

      message.update!(recognized_text: recognized_text)

      Telegram::DeleteMessage.call(message.chat_id, message.response_message_id)
      Telegram::SendMessage.call(message.chat_id, recognized_text, reply_to: message.message_id)
    else
      message.voice_file.attach(
        io: File.open(file_path),
        filename: message.tmp_file_name
      )

      operation_id = Yandex::AsyncStt.call(message.voice_file.url)
      message.update!(recognition_id: operation_id)

      YandexSttStatusChecker.perform_later(operation_id)
    end

    FileUtils.rm(file_path)
  end
end
