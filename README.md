# FAKE EXPENSES GENERATOR

### Generate fake expense data for testing purposes.

Generates a CSV like this:
| user | date | amount | reason
| ----------- | ----------- | ----------- | ----------- |
| Sterling Dibbert | 2023-01-01 | 3331 | salary |
| Sterling Dibbert | 2023-01-02 | -168 | Heavy Duty Wooden Keyboard |
| Sterling Dibbert | 2023-02-04 | -195 | Toaster and toaster ovens |
| Rip Torn | 2023-01-01 | 2895 | salary |
| Rip Torn | 2023-01-01 | -75 | Pokémon FireRed |
| Rip Torn | 2023-01-02 | -142 | Oil heater |
| Rip Torn | 2023-02-03 | -131 | Aerodynamic Paper Hat |
---
#### Installation
1. Clone this repo to use it locally:
- `https://github.com/kaimunlau/fake-data-generator.git`
*or*
- `git@github.com:kaimunlau/fake-data-generator.git`
*or*
- `gh repo clone kaimunlau/fake-data-generator`
2. Install dependencies:
- This program uses [faker-ruby](https://github.com/faker-ruby/faker) to generate dummy data. Install it by running `gem install faker`
---
#### Usage
1. Navigate to your repo `cd <path_tp_your_repo>`
2. Run generator using `ruby data_generator.rb`
---
#### Configuration
You can tweak settings to your liking by editing the values in `config.yml`
