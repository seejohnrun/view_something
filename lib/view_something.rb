require 'digest/md5'

module ViewSomething

  autoload :VERSION, File.dirname(__FILE__) + '/view_something/version'

  def self.has_known_view?(digest)
    @known_views ||= []
    @known_views.include?(digest)
  end

  def self.view(query)
    digest = Digest::MD5.hexdigest(sql = query.to_sql)
    ensure_view_exists(digest, sql)
    query.klass.find_by_sql "SELECT * FROM `#{digest}`;"
  end

  def self.ensure_view_exists(digest, sql)
    unless has_known_view?(digest)
      connection_klass = ActiveRecord::Base.connection.class
      adapter = connection_klass.name.split('::')[-1]
      if ['SQLite3Adapter'].include?(adapter)
        ActiveRecord::Base.connection.execute "DROP VIEW IF EXISTS '#{digest}'"
        ActiveRecord::Base.connection.execute "CREATE VIEW '#{digest}' AS #{sql}"
      elsif ['MysqlAdapter', 'Mysql2Adapter'].include?(adapter)
        ActiveRecord::Base.connection.execute "CREATE OR REPLACE VIEW #{digest} AS #{sql}"
      else
        raise "Database type #{connection_klass.name} not supported by ViewSomething"
      end
    end
  end
 
end
