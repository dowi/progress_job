module ProgressJob

  module Generators
    class InstallGenerator < Rails::Generators::Base
      include Rails::Generators::Migration

      source_root File.expand_path("templates", __dir__)

      def install
        migration_template \
          "migration.rb", "db/migrate/add_progress_to_delayed_jobs.rb"
        route "get \"progress-job/:job_id\" => \"progress_job/progress#show\""
      end

      def self.next_migration_number(path)
        @migration_number = Time.now.utc.strftime("%Y%m%d%H%M%S").to_i.to_s
      end

      def migration_version
        if Rails::VERSION::MAJOR >= 5 then
          "[#{Rails::VERSION::MAJOR}.#{Rails::VERSION::MINOR}]"
        end
      end
    end
  end
end
