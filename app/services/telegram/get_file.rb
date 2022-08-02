module Telegram
  class GetFile < ApplicationService
    def initialize(file_id)
      @file_id = file_id
    end

    def call
      parsed_response.dig("result", "file_path")
    end

    private

    attr_reader :file_id

    def get_file_url
      "#{API_BASE_URL}/getFile"
    end

    def query
      {
        file_id: file_id
      }
    end

    def parsed_response
      @parsed_response ||= HTTParty.get(get_file_url, query: query).parsed_response
    end
  end
end
