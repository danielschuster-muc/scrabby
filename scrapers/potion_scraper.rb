# frozen_string_literal: true

require_relative 'basic_scraper'

# scrapers/potion_scraper.rb
class PotionScraper < BasicScraper
  def self.scrape_page(url, potions)
    doc = doc(url)

    url = CGI.unescape(url)
    name = doc.css('h2.pi-item.pi-item-spacing.pi-title')&.first&.text || doc.css('#firstHeading')&.first&.text
    return puts "no name for #{url}" unless name

    potion = {
      name: name.gsub('"', "'").gsub("\t", '').gsub("\n", ''),
      slug: url.gsub('https://harrypotter.fandom.com/wiki/', '').gsub('_', '-').parameterize,

      characteristics: data_by_data_tag(doc.at('.pi-data[data-source="characteristics"]'))&.join(', '),
      difficulty: data_by_data_tag(doc.at('.pi-data[data-source="difficulty"]'))&.join(', '),
      effect: data_by_data_tag(doc.at('.pi-data[data-source="effect"]'))&.join(', '),
      image: (image_element = doc.at('.image-thumbnail')) ? image_element['href']&.gsub(/\/revision\/latest\?cb=(\d*)*/, '') : nil,
      ingredients: data_by_data_tag(doc.at('.pi-data[data-source="ingredients"]'))&.join(', '),
      inventors: data_by_data_tag(doc.at('.pi-data[data-source="inventor"]'))&.join(', '),
      manufacturers: data_by_data_tag(doc.at('.pi-data[data-source="manufacturer"]'))&.join(', '),
      side_effects: data_by_data_tag(doc.at('.pi-data[data-source="side-effects"]'))&.join(', '),
      time: data_by_data_tag(doc.at('.pi-data[data-source="time"]'))&.join(', '),
      wiki: url
    }

    puts "Scraped #{potion[:slug]}"

    potion unless potions.include?(potion)
  end
end
