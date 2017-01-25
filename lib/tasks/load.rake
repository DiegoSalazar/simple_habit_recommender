namespace :load do
  DATA_FILE = ENV.fetch "DATA_FILE", "./lib/data/listens.json"
  SUBTOPIC_FILE = ENV.fetch "SUBTOPIC_FILE", "./lib/data/subtopics.json"

  desc "Load the listens.json file into the db"
  task listens: :environment do
    listens = JSON.parse File.read DATA_FILE
    puts "Loading #{listens.size} listen records..."

    Listen.bulk_insert do |worker|
      listens.each do |listen|
        worker.add({
          subtopic_id: listen["subtopic"],
          listen_date: listen["listenDate"],
          user_id: listen["user"]
        })
      end
    end

    puts "\aDone."
  end

  desc "Load the subtopics.json file into the db"
  task sub_topics: :environment do
    sub_topics = JSON.parse File.read SUBTOPIC_FILE
    puts "Loading #{sub_topics.size} subtopic records..."

    SubTopic.bulk_insert do |worker|
      sub_topics.each do |sub_topic|
        worker.add({
          name: sub_topic["name"],
          description: sub_topic["description"],
          subtopic_id: sub_topic["id"]
        })
      end
    end

    puts "\aDone."
  end

  desc "Create users from listen models. Do this after running \`load:listens\`"
  task users: :environment do
    puts "Creating #{Listen.uniq_user_count} users..."

    listens = Listen.uniq_by_user.map { |listen| { user_id: listen.user_id } }
    User.bulk_insert values: listens

    puts "\aDone."
  end

  desc "Clear listens, sub_topics, and users tables"
  task reset: :environment do
    [Listen, SubTopic, User].map &:delete_all
  end
end