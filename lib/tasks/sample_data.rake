namespace :db do
  desc "Fill database with sample data"
  task populate: :environment do
    
    topics = Topic.all(limit: 10)
    seq=0
    50.times do
      seq=seq+100
      text = Faker::Lorem.sentence(5)
      topics.each { |topic| topic.notes.create!(sequence: seq, text: text) }
    end
  end
end