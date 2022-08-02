module Telegram
  class DeleteMessage < ApplicationService
    def initialize(chat_id, message_id)
      @chat_id = chat_id
      @message_id = message_id
    end

    def call
      HTTParty.post(delete_message_url, body: body, headers: headers)
    end

    private

    attr_reader :chat_id, :message_id

    def delete_message_url
      "#{API_BASE_URL}/deleteMessage"
    end

    def body
      {
        chat_id: chat_id,
        message_id: message_id
      }.to_json
    end

    def headers
      {"Content-Type" => "application/json"}
    end
  end
end
