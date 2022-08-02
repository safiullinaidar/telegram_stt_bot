module Messages
  class Create < ApplicationService
    def initialize(params)
      @params = params
    end

    def call
      return unless voice_message?

      message = create_message!

      YandexSttJob.perform_later(message.id)
    end

    private

    attr_reader :params

    def create_message!
      Message.create!(
        chat_id: chat_id,
        message_id: message_id,
        file_id: file_id,
        duration: duration
      )
    end

    def chat_id
      params.dig(:chat, :id)
    end

    def message_id
      params[:message_id]
    end

    def voice_message?
      params[:voice].present?
    end

    def file_id
      params.dig(:voice, :file_id)
    end

    def duration
      params.dig(:voice, :duration)
    end
  end
end
