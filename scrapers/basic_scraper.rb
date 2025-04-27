# frozen_string_literal: true

require 'csv'
require 'nokogiri'
require 'open-uri'
require 'cgi'
require 'active_support/core_ext/string/inflections'

# scrapers/basic_scraper.rb
class BasicScraper
  def self.doc(url)
    begin
      file = URI.parse(url).open.read
      Nokogiri::HTML(file)
    rescue SocketError => e
      puts "Failed to fetch URL: #{url} - #{e.message}"
      nil
    end
  end

  def self.data_by_data_tag(element)
    return unless element

    search = element.search('.pi-data-value').first
    return unless search

    listed_search = search.search('ul li')
    if listed_search.first
      result = listed_search.map(&:text)
    elsif search
      result = [search.inner_text]
    end

    zitation_regex = /\[((\d*)|(\w+(\s\w+)*))\]/ # e.g. [1] or [1 2 3] or [a] or [a b c]
    result.map { |r| r.strip.gsub(zitation_regex, '').gsub("\t", '').gsub("\n", '').gsub('"', "'") }
  end
end
