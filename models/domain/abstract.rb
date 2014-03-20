require 'sqlite3'

module Infradash
  module Domain
    class Abstract
      attr_accessor :responsible, :organization, :client, :project, \
                    :environment, :description, :ip

      def self.db=(file)
        @@db = SQLite3::Database.new(file)
        @@db.results_as_hash = true
      end

      def initialize()
        row = @@db.get_first_row("SELECT * FROM machines WHERE name = ?", name)

        @pk = row['id']
        @responsible = row['responsible']
        @organization = row['organization']
        @client = row['client']
        @project = row['project']
        @environment = row['environment']
        @description = row['description']
        @ip = []

        @@db.execute("SELECT * FROM network WHERE machine_id = ?", @pk) do |row|
          @ip << row['ip']
        end
      end

      def name
      end

      def state
      end

      def cpu
      end

      def memory
      end

    end
  end
end
