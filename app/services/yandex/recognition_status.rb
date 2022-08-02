module Yandex
  class RecognitionStatus < Base
    API_URL = "https://operation.api.cloud.yandex.net/operations".freeze
    private_constant :API_URL

    def initialize(operation_id)
      @operation_id = operation_id
    end

    def call
      return unless done?
      
      parsed_response.dig("response", "chunks").map do |chunk|
        chunk["alternatives"].first["text"]
      end.join(" ")
    end

    private

    attr_reader :operation_id

    def operation_url
      "#{API_URL}/#{operation_id}"
    end

    def parsed_response
      @parsed_response ||= HTTParty.get(operation_url, headers: auth_header).parsed_response
    end

    def done?
      parsed_response["done"]
    end
  end
end
