# frozen_string_literal: true

require 'link_thumbnailer/model'

module LinkThumbnailer
  module Models
    class Response < ::LinkThumbnailer::Model

      module Types
        WEBPAGE = 'webpage'
        IMAGE = 'image'
        OTHER = 'other'
      end

      attr_reader :code, :headers, :body

      def initialize(http_response)
        @code = http_response.code
        @headers = http_response.header.to_hash
        @body = http_response.body
      end

      def content_type
        (headers['content-type'] || @headers['Content-Type'])&.first
      end

      def type
        case content_type
        when /^text\/html/, /^application\/html/
          Types::WEBPAGE
        when /^image\//
          Types::IMAGE
        else
          Types::OTHER
        end
      end

    end
  end
end
