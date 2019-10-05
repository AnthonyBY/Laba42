# frozen_string_literal: true

desc 'Delete all unconfirmed users after 7 days'
task delete_unconfirmed_users: :environment do
  users = User.where(confirmed_at: nil).or(User.where('confirmation_sent_at >= ?', 7.day.ago))
  # May be remove this block after testing for automitization ---
  if users.length.zero?
    puts 'All clear. Nothing to delete'
  else
    puts '-------------------------------------------------------------------------------------------'
    puts '        Created         |  UserID   |   Confirmation_sent_at  |-| Confirmed_at            |'
    puts '-------------------------------------------------------------------------------------------'
    # -------------------------------------------------------------
    users.each do |user|
      # May be remove this block after testing ---
      puts "#{user.created_at} | #{(user.id <= 9 ? "UserID:0#{user.id}" : "UserID:#{user.id}")} " \
            "| #{user.confirmation_sent_at} |-| #{user.confirmed_at} | . "\
            "| #{user.confirmation_token} |-| #{user.unconfirmed_email} |"
      # ------------------------------------------------------------
      # user.destroy # activate after testing for automitization ---
    end
    # May be remove this block after testing for automitization ---
    puts '-------------------------------------------------------------------------------------------'
    puts 'Are you sure you want to delete these accounts?'
    puts "(anything other than 'yes' will cancel)"
    users.each(&:destroy) if STDIN.gets.chomp == 'yes'
    puts 'Done'
  end
  # ------------------------------------------------------------
end
