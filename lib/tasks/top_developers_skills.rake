# frozen_string_literal: true

desc 'Show top skills of registered developers'
task top_developers_skills: :environment do
  def histogram(arr)
    arr.each_with_object(Hash.new(0)) do |skills, counter|
      counter[skills] += 1
    end
  end

  def all_skills
    User.developer.map(&:skills).flatten
  end

  def skills_count
    histogram(all_skills)
  end

  def skills_sort
    skills_count.sort_by { |_key, value| value }.reverse
  end

  skills_sort.each { |arr| puts "#{arr[1]}-#{arr[0]}" }
end
