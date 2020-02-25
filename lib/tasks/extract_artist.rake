namespace :extract_artist do
  desc "extract artist"
  task :test => :environment do
    File.open('./test.txt').each do |line|
      print line
    end
  end

  desc "TODO"
  task :my_task2 => :environment do
  end
end
