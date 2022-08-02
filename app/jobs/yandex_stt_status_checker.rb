class YandexSttStatusChecker < ApplicationJob
  queue_as :default

  def perform(operation_id)
    recognized_text = Yandex::RecognitionStatus.call(operation_id)

    if recognized_text
      message = Message.find_by(recognition_id: operation_id)
      message.update!(recognized_text: recognized_text)
      message.voice_file.purge

      Telegram::DeleteMessage.call(message.chat_id, message.response_message_id)
      Telegram::SendMessage.call(message.chat_id, recognized_text, reply_to: message.message_id)
    else
      sleep 3
      YandexSttStatusChecker.perform_later(operation_id)
    end
  end
end
