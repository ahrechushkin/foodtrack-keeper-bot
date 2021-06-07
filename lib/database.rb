require 'pg'
require 'yaml'

module Database
  APP_ENV = ENV['APP_ENV']
  DB_NAME = YAML.load_file('config/database.yml')[APP_ENV.to_sym][:name]

  module Executor
    attr_accessor :db

    def setup
      begin
        self.db = PG.connect(dbname: DB_NAME)
      rescue PG::ConnectionBad
        puts 'Creating a new database'
        create_db
      end
    end

    def create_db
      db = PG.connect(dbname: 'postgres')
      db.exec <<-SQL
        CREATE DATABASE #{DB_NAME};
      SQL
    end

    def drop_db
      db = PG.connect(dbname: 'postgres')
      db.exec <<-SQL
        DROP DATABASE #{DB_NAME};
      SQL
    end

    def create_table(schema)
      db.exec <<-SQL
        #{schema}
      SQL
    end

    module_function(
      :db,
      :db=,
      :setup,
      :create_db,
      :drop_db,
      :create_table,
    )
  end
end