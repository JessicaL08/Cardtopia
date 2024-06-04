require 'pry-byebug'
namespace :db do

  desc "Dumps the database to db/APP_NAME.dump"
  task :dump => :environment do
    cmd = nil
    with_config do | host, db, user|
      cmd = "pg_dump --host #{host} --username #{user} --verbose --clean --no-owner --no-acl --format=c #{db} > #{Rails.root}/db/cardtopia_db.dump"
    end
    puts cmd
    exec cmd
  end

  desc "Restores the database dump at db/APP_NAME.dump."
  task :restore => :environment do
    cmd = nil
    with_config do | host, db, user|
      cmd = "pg_restore --verbose --host #{host} --username #{user} --clean --no-owner --no-acl --dbname #{db} #{Rails.root}/db/cardtopia_db.dump"
    end
    # Rake::Task["db:drop"].invoke
    # Rake::Task["db:create"].invoke
    puts cmd
    exec cmd
  end

  private

  def with_config
    binding.pry
    yield Rails.env.development? ? 'localhost' : ActiveRecord::Base.connection_db_config[:host],
    ActiveRecord::Base.connection_db_config.configuration_hash[:database],
    Rails.env.development? ? 'postgres' : 'cardtopia'
  end

end
