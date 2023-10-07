# Scrabby
Your magical assistant for scraping data from the Harry Potter Wiki.

## How it works
Scrabby scrapes data from the [Harry Potter Wiki](https://harrypotter.fandom.com/wiki/Main_Page), transforms it into valid format and saves it to `data/*.csv`.
This data can be used for further analysis and also powers the [Harry Potter API](https://github.com/danielschuster-muc/potter-db).

## Setup
Normally you don't need to setup anything. The data will be automatically scraped and updated once a week. If you want to run the scrapers manually, follow these steps:

1. Clone this repository
```bash
git clone git@github.com:danielschuster-muc/scrabby.git && cd scrabby
```
2. Install ruby
```bash
rbenv install 3.1.2
```
3. Install dependencies
```bash
bundle install
```
4. Run scrapers
```bash
bundle exec rake scrabby:characters
bundle exec rake scrabby:potions
bundle exec rake scrabby:spells
```
5. Output
The fresh scraped data will be saved to `data/*.csv`.

## License
This project is licensed under the terms of the MIT license. See the [LICENSE](LICENSE) file.
