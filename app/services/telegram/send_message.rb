module Telegram
  class SendMessage < ApplicationService
    def initialize(chat_id, text, reply_to: nil)
      @chat_id = chat_id
      @text = text
      @reply_to = reply_to
    end

    def call
      parsed_response["message_id"]
    end

    private

    attr_reader :chat_id, :text, :reply_to

    def send_message_url
      "#{API_BASE_URL}/sendMessage"
    end

    def body
      {
        chat_id: chat_id,
        text: text,
        reply_to_message_id: reply_to,
        allow_sending_without_reply: true
      }.compact.to_json
    end

    def headers
      {"Content-Type" => "application/json"}
    end

    def parsed_response
      @parsed_response ||= HTTParty.post(send_message_url, body: body, headers: headers).parsed_response
    end
  end
end
