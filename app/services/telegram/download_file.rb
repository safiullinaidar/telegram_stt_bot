module Telegram
  class DownloadFile < ApplicationService
    def initialize(message)
      @message = message
    end

    def call
      @tg_file_path = GetFile.call(message.file_id)

      file_path = Rails.root.join("tmp", message.tmp_file_name)

      File.open(file_path, "w") do |file|
        file.binmode
        HTTParty.get(file_download_url, stream_body: true) do |fragment|
          file.write(fragment)
        end
      end

      file_path
    end

    private

    attr_reader :message, :tg_file_path

    def file_download_url
      "https://api.telegram.org/file/bot#{TELEGRAM_BOT_TOKEN}/#{tg_file_path}"
    end
  end
end
