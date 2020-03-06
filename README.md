# Simple log parser

[![CircleCI](https://circleci.com/gh/jedbr/log_parser.svg?style=svg)](https://circleci.com/gh/jedbr/log_parser)
[![Maintainability](https://api.codeclimate.com/v1/badges/8149a42a64ab31552223/maintainability)](https://codeclimate.com/github/jedbr/log_parser/maintainability)
[![Test Coverage](https://api.codeclimate.com/v1/badges/8149a42a64ab31552223/test_coverage)](https://codeclimate.com/github/jedbr/log_parser/test_coverage)

## Requirements
- Ruby 2.7

## Installation
1. Clone repository
   ```bash
   git clone https://github.com/jedbr/log_parser.git
   ```
2. Move to the directory
   ```bash
   cd log_parser
   ```
3. Build gem
   ```bash
   gem build log_parser.gemspec
   ```
4. Install gem
   ```bash
   gem install log_parser
   ```

You can also add the gem to your Gemfile by adding line:
```bash
gem "log_parser", git: "https://github.com/jedbr/log_parser.git"
```

## Usage
Basic example - parse log file with default parameters (print both lists of webpages ordered by most view pages and by unique views in descending order)
```bash
log_parser webserver.log
```

Print list of webpages ordered by unique views in ascending order only
```bash
log_parser webserver.log -t unique -o asc
```

If you get stuck, try
```bash
log_parser help
```

## Tests

Make sure all development dependencies are installed:
```bash
bundle install
```

To test the code, run:
```bash
bundle exec rspec
```

To run linter, type:
```bash
bundle exec rubocop
```
