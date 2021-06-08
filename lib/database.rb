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
        create_db && self.db = PG.connect(dbname: DB_NAME)
        schema.map do  |table_schema|
          puts '-----------'
          puts table_schema
          puts '-----------'
          create_table(table_schema)
        end
        puts 'Database created successfully'
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

    def schema
      schema_mapper = YAML.load_file('./config/database/schema.yml')
      schema_mapper.keys.map do |table| 
        columns = schema_mapper[table]["columns"]
        types = columns.map do |column, value|
          "#{column} #{value["type"]}"
        end.join(',')
      "CREATE TABLE #{table} (#{types});"
      end
    end      

    module_function(
      :db,
      :db=,
      :setup,
      :create_db,
      :drop_db,
      :create_table,
      :schema,
    )
  end
end