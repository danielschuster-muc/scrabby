# Scrabby

Scrabby is a Ruby-based tool that collects data from the [Harry Potter Wiki](https://harrypotter.fandom.com/wiki/Main_Page), covering characters, potions, and spells.
It powers the [Potter DB](https://github.com/danielschuster-muc/potter-db) by keeping its magical database up to date with reliable, well-structured information from the wizarding world.

## How it works

Scrabby performs the following spellbinding tasks:

1. Data scraping: Scrabby collects data from the Harry Potter Wiki using [Nokogiri](https://nokogiri.org/). It focuses on characters, potions, and spells.
2. Data transformation: Scrabby then organizes the data into a clean and easy-to-use format, using [CSV](https://en.wikipedia.org/wiki/Comma-separated_values), so it's ready to use right away.
3. Data storage: Scrabby saves the transformed into separate CSV files in the `data/` folder, making it easy to analyze or use in other projects.

## Setup

You usually don’t need to do anything. Scrabby automatically scrapes and updates the data once a month using [GitHub Actions](.github/workflows).
But if you want to run the scrapers yourself, just follow these simple steps:

### 1. Clone the repository

```bash
git clone https://github.com/danielschuster-muc/scrabby.git && cd scrabby
```

### 2. Install ruby

Ensure you have Ruby `3.4.5` installed on your system.

```bash
rbenv install 3.4.5
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

The fresh scraped data will be saved to `data/*.csv`.

## License

This project is licensed under the terms of the MIT license. See the [LICENSE](LICENSE) file.

Data is scraped from the [Harry Potter Wiki](https://harrypotter.fandom.com/wiki/Main_Page) and therefore licensed under [CC-BY-SA](https://www.fandom.com/licensing) unless otherwise stated. For specific details, please refer to the URLs linking to the corresponding wiki pages in the [data](/data) files.
