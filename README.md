# Scrabby
Scrabby is a Ruby-based tool designed to scrape data from the [Harry Potter Wiki](https://harrypotter.fandom.com/wiki/Main_Page).
This project is an essential component powering the [Potter DB](https://github.com/danielschuster-muc/potter-db), providing an up-to-date data repository of all characters, potions and spells from the Harry Potter universe.

## How it works
Scrabby performs the following spellbinding tasks:

1. Data scraping: Scrabby scrapes data from the Harry Potter Wiki using [Nokogiri](https://nokogiri.org/), extracting valueable insights about characters, potions and spells.
2. Data transformation: Scrabby transforms the scraped data into a structured format, using [CSV](https://en.wikipedia.org/wiki/Comma-separated_values) as the data format, making it ready to use for immediate use.
3. Data storage: Scrabby stores the transformed to individual CSV files within `data/`, allowing easy access for analysis or integration with other projects.

## Setup
Normally you don't need to setup anything. The data will be automatically scraped and updated once a week, by using [GitHub Actions](.github/workflows).
However, if you'd like to take the reins and run the scrapers manually, follow these simple steps:

### 1. Clone the repository
```bash
git clone git@github.com:danielschuster-muc/scrabby.git && cd scrabby
```
### 2. Install ruby
Ensure you have Ruby `3.1.2` installed on your system.
```bash
rbenv install 3.1.2
```
### 3. Install dependencies
```bash
bundle install
```
### 4. Run scrapers
Execute the following commands to manually trigger the scrapers for characters, potions, and spells:
```bash
bundle exec rake scrabby:characters
bundle exec rake scrabby:potions
bundle exec rake scrabby:spells
```
### 5. Output
The fresh scraped data will be saved to `data/*.csv`, conveniently available for your use.

## License
This project is licensed under the terms of the MIT license. See the [LICENSE](LICENSE) file.
