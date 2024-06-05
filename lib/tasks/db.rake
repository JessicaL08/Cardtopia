require 'pry-byebug'
namespace :db do

  desc "Dumps the database to db/APP_NAME.dump"
  task :dump => :environment do
    cmd = nil
    with_config do | host, db, user|
      cmd = "pg_dump --host #{host} --username #{user} --verbose --clean --no-owner --no-acl --format=c -d #{db} -f #{Rails.root}/db/cardtopia_dbV2.dump"
      # "pg_dump -F c -v -h #{host} -d #{db} -f #{Rails.root}/db/cardtopia_dbv2.dump"
    end
    puts cmd
    exec cmd
  end

  desc "Restores the database dump at db/APP_NAME.dump."
  task :restore => :environment do
    cmd = nil
    with_config do | host, db, user|
      cmd = "pg_restore --verbose --host #{host} --username #{user} --clean --no-owner --no-acl --dbname #{db} -C #{Rails.root}/db/cardtopia_dbV2.dump"
      # "pg_restore -F #{fmt} -v -c -C #{file}"
    end
    # Rake::Task["db:drop"].invoke
    # Rake::Task["db:create"].invoke
    puts cmd
    exec cmd
  end

  private

  def with_config

    yield Rails.env.development? ? 'localhost' : ActiveRecord::Base.connection_db_config.configuration_hash[:host],
    ActiveRecord::Base.connection_db_config.configuration_hash[:database],
    Rails.env.development? ? 'postgres' : ActiveRecord::Base.connection_db_config.configuration_hash[:username]
  end
end
