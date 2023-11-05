# frozen_string_literal: true

require 'csv'
require 'yaml'
require 'faker'

config = YAML.load_file('config.yml')
CSV_FILE_PATH = config['csv_file_path']
NUMBER_OF_USERS = config['number_of_users']
MAX_EXPENSES_PER_DAY = config['max_expenses_per_day']
MIN_USER_EXPENSE = config['min_user_expense']
MAX_USER_EXPENSE = config['max_user_expense']
MIN_USER_INCOME = config['min_user_income']
MAX_USER_INCOME = config['max_user_income']
start_month = config['start_month']
end_month = config['end_month']
MONTHS = (start_month..end_month).to_a
DAYS = (1..28).to_a # Arbitrarily ending month on 28 to avoid dealing with February.

# Sometimes multiple calls to Faker will return the same value.
# This function returns true after making sure no duplicate users were generated.
def no_duplicates_found(users)
  puts "Checking for duplicate users...\n\n"
  users.tally.each_value do |value|
    next unless value > 1

    puts "Duplicate found!\n\n"
    puts "Duplicate user was: #{users.tally.key(value)}\n\n"
    puts "Regenerating...\n\n"
    return false
  end
  puts "No duplicates found :)\n\n"
  true
end

def generate_user(users)
  possible_names = [ # Add additional calls to Faker in this array to diversify the possible names.
    Faker::FunnyName.name,
    Faker::FunnyName.two_word_name,
    Faker::FunnyName.three_word_name,
    Faker::FunnyName.four_word_name,
    "#{Faker::Name.first_name} #{Faker::Name.last_name}"
  ]
  user = possible_names.sample
  users << user
  user
end

def make_salary_row(data, user, month, day)
  date = "2023-#{month < 10 ? "0#{month}" : month}-0#{day}"
  data << {
    user: user,
    date: date,
    amount: rand(MIN_USER_INCOME..MAX_USER_INCOME),
    reason: 'salary'
  }
end

def make_expense_rows(data, user, month, day)
  rand(1..MAX_EXPENSES_PER_DAY).times do
    possible_reasons = [Faker::Appliance.equipment, Faker::Commerce.product_name, Faker::Game.title]
    date = "2023-#{month < 10 ? "0#{month}" : month}-#{day < 10 ? "0#{day}" : day}"
    data << {
      user: user,
      date: date,
      amount: -rand(MIN_USER_EXPENSE..MAX_USER_EXPENSE),
      reason: possible_reasons.sample
    }
  end
end

def make_daily_transactions(users, data)
  NUMBER_OF_USERS.times do
    user = generate_user(users)
    MONTHS.each do |month|
      DAYS.each do |day|
        make_salary_row(data, user, month, day) if day == 1
        make_expense_rows(data, user, month, day)
      end
    end
  end
end

def make_data
  data = []
  users = []

  puts "Creating fake data...\n\n"

  make_daily_transactions(users, data)

  return make_data unless no_duplicates_found(users) # Restarts the generator if duplicate users were found

  puts "Finished creating fake data!\n\n"

  data
end

def write_to_csv(data)
  puts "Writing to CSV...\n\n"

  CSV.open(CSV_FILE_PATH, 'wb') do |csv|
    csv << %w[user date amount reason]
    data.each do |row|
      csv << [row[:user], row[:date], row[:amount], row[:reason]]
    end
  end

  puts "Finished writing to CSV!\n\n"
end

write_to_csv(make_data)
