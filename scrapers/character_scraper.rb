# frozen_string_literal: true

require_relative 'basic_scraper'

# scrapers/character_scraper.rb
class CharacterScraper < BasicScraper
  def self.scrape_page(url, characters)
    doc = doc(url)

    url = CGI.unescape(url)
    name = doc.css('h2.pi-item.pi-item-spacing.pi-title')&.first&.text || doc.css('#firstHeading')&.first&.text
    return puts "No name for #{url}" unless name

    character = {
      name: name.gsub('"', "'").gsub("\t", '').gsub("\n", ''),
      slug: url.gsub('https://harrypotter.fandom.com/wiki/', '').gsub('_', '-').parameterize,

      alias_names: "{#{data_by_data_tag(doc.at('.pi-data[data-source="alias"]'))&.map { |s| "\"#{s}\"" }&.join(', ')}}",
      animagus: data_by_data_tag(doc.at('.pi-data[data-source="animagus"]'))&.join(', '),
      blood_status: data_by_data_tag(doc.at('.pi-data[data-source="blood"]'))&.join(', '),
      boggart: data_by_data_tag(doc.at('.pi-data[data-source="boggart"]'))&.join(', '),
      born: data_by_data_tag(doc.at('.pi-data[data-source="born"]'))&.join(', ')&.gsub(/(?<=([0-9]|\)))(?=[A-Z])/, ', ')&.gsub('"', ''),
      died: data_by_data_tag(doc.at('.pi-data[data-source="died"]'))&.join(', ')&.gsub(/(?<=([0-9]|\)))(?=[A-Z])/, ', '),
      eye_color: data_by_data_tag(doc.at('.pi-data[data-source="eyes"]'))&.join(', '),
      family_members: "{#{data_by_data_tag(doc.at('.pi-data[data-source="family"]'))&.map { |s| "\"#{s}\"" }&.join(', ')}}",
      gender: data_by_data_tag(doc.at('.pi-data[data-source="gender"]'))&.join(', '),
      hair_color: data_by_data_tag(doc.at('.pi-data[data-source="hair"]'))&.join(', ')&.gsub('"', ''),
      height: data_by_data_tag(doc.at('.pi-data[data-source="height"]'))&.join(', '),
      house: data_by_data_tag(doc.at('.pi-data[data-source="house"]'))&.join(', '),
      image: (image_element = doc.at('.image-thumbnail')) ? image_element['href']&.gsub(/\/revision\/latest\?cb=(\d*)*/, '') : nil,
      jobs: "{#{data_by_data_tag(doc.at('.pi-data[data-source="job"]'))&.map { |s| "\"#{s}\"" }&.join(', ')}}",
      marital_status: data_by_data_tag(doc.at('.pi-data[data-source="marital"]'))&.join(', '),
      nationality: data_by_data_tag(doc.at('.pi-data[data-source="nationality"]'))&.join(', '),
      patronus: data_by_data_tag(doc.at('.pi-data[data-source="patronus"]'))&.join(', '),
      romances: "{#{data_by_data_tag(doc.at('.pi-data[data-source="romances"]'))&.map { |s| "\"#{s}\"" }&.join(', ')}}",
      skin_color: data_by_data_tag(doc.at('.pi-data[data-source="skin"]'))&.join(', ')&.gsub('"', ''),
      species: data_by_data_tag(doc.at('.pi-data[data-source="species"]'))&.join(', '),
      titles: "{#{data_by_data_tag(doc.at('.pi-data[data-source="title"]'))&.map { |s| "\"#{s}\"" }&.join(', ')}}",
      wands: "{#{data_by_data_tag(doc.at('.pi-data[data-source="wand"]'))&.map { |s| "\"#{s}\"" }&.join(', ')}}",
      weight: data_by_data_tag(doc.at('.pi-data[data-source="weight"]'))&.join(', '),
      wiki: url
    }

    puts "Scraped #{character[:slug]}"

    character unless characters.include?(character)
  end
end
