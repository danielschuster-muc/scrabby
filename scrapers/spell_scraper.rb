# frozen_string_literal: true

require_relative 'basic_scraper'

# scrapers/spell_scraper.rb
class SpellScraper < BasicScraper
  def self.scrape_page(url, spells)
    doc = doc(url)

    url = CGI.unescape(url)
    name = doc.css('h2.pi-item.pi-item-spacing.pi-title')&.first&.text || doc.css('#firstHeading')&.first&.text
    return puts "no name for #{url}" unless name

    spell = {
      name: name.gsub('"', "'").gsub("\t", '').gsub("\n", ''),
      slug: url.gsub('https://harrypotter.fandom.com/wiki/', '').gsub('_', '-').parameterize,

      category: data_by_data_tag(doc.at('.pi-data[data-source="type"]'))&.join(', '),
      creator: data_by_data_tag(doc.at('.pi-data[data-source="creator"]'))&.join(', '),
      effect: data_by_data_tag(doc.at('.pi-data[data-source="effect"]'))&.join(', '),
      hand: (hand = data_by_data_tag(doc.at('.pi-data[data-source="hand"]'))&.join(', '))&.empty? ? nil : hand,
      image: (image_element = doc.at('.image-thumbnail')) ? image_element['href']&.gsub(/\/revision\/latest\?cb=(\d*)*/, '') : nil,
      incantation: data_by_data_tag(doc.at('.pi-data[data-source="incantation"]'))&.join(', '),
      light: data_by_data_tag(doc.at('.pi-data[data-source="light"]'))&.join(', '),
      wiki: url
    }

    puts "Scraped #{spell[:slug]}"

    spell unless spells.include?(spell)
  end
end
