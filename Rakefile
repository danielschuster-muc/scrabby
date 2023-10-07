# frozen_string_literal: true

require 'csv'
require 'nokogiri'
require 'open-uri'

require './scrapers/character_scraper'
require './scrapers/potion_scraper'
require './scrapers/spell_scraper'

base_url = 'https://harrypotter.fandom.com'

namespace :scrabby do
  desc 'Scrape characters from the Harry Potter Wiki'
  task :characters do
    puts 'Start scraping characters...'

    character_links = []
    genders = %w[Females Males Individuals_of_unknown_or_undetermined_gender]
    genders.each do |gender|
      scrape_character_links("#{base_url}/wiki/Category:#{gender}", base_url, character_links)
    end

    characters = []
    character_links.take(10).sort!.each do |url|
      characters << CharacterScraper.scrape_page(url, characters)
    end

    CSV.open('data/characters.csv', 'w') do |csv|
      csv << characters.first.keys
      characters.each { |character| csv << character.values }
    end

    puts "Scraped #{characters.count} characters!"
  end

  desc 'Scrape potions from the Harry Potter Wiki'
  task :potions do
    puts 'Start scraping potions...'

    potion_links = []
    scrape_potion_links(base_url, potion_links)

    potions = []
    potion_links.sort!.each do |url|
      potions << PotionScraper.scrape_page(url, potions)
    end

    CSV.open('data/potions.csv', 'w') do |csv|
      csv << potions.first.keys
      potions.each { |potion| csv << potion.values }
    end
  end

  desc 'Scrape spells from the Harry Potter Wiki'
  task :spells do
    puts 'Start scraping spells...'

    spell_links = []
    scrape_spell_links(base_url, spell_links)

    spells = []
    spell_links.sort!.each do |url|
      spells << SpellScraper.scrape_page(url, spells)
    end

    CSV.open('data/spells.csv', 'w') do |csv|
      csv << spells.first.keys
      spells.each { |spell| csv << spell.values }
    end
  end
end

def scrape_character_links(url, base_url, links)
  file = URI.parse(url).open.read
  doc = Nokogiri::HTML(file)

  doc.search('.category-page__member-link').each do |element|
    character_link = base_url + element.attribute('href').value
    links << character_link unless links.include?(character_link)
  end

  next_page = doc.search('.category-page__pagination-next').first
  scrape_character_links(next_page.attribute('href').value, base_url, links) if next_page
end

def scrape_potion_links(base_url, links)
  file = URI.parse("#{base_url}/wiki/List_of_potions").open.read
  doc = Nokogiri::HTML(file)

  doc.search('div.wds-tab__content > ul > li > a').each do |element|
    potion_link = CGI.unescape(base_url + element.attribute('href').value)
    links << potion_link unless links.include?(potion_link)
  end

  doc.search('div.wds-tab__content > li > a').each do |element|
    potion_link = CGI.unescape(base_url + element.attribute('href').value)
    links << potion_link unless links.include?(potion_link)
  end
end

def scrape_spell_links(base_url, links)
  file = URI.parse("#{base_url}/wiki/List_of_spells").open.read
  doc = Nokogiri::HTML(file)

  doc.search('.wds-tab__content > h3 > span a').each do |element|
    spell_link = base_url + element.attribute('href').value
    links << spell_link unless links.include?(spell_link)
  end
end
