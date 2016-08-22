require_relative 'db_connection'
require_relative '01_sql_object'

module Searchable
  def where(params)
    vals = params.values
    where_line = params.keys.map { |k| "#{k.to_s} = ?"}.join(" AND ")

    results = DBConnection.execute(<<-SQL, *vals)
      SELECT
        *
      FROM
        #{self.table_name}
      WHERE
        #{where_line}
    SQL

    results.map { |result| self.new(result) }
  end
end

class SQLObject
  # Mixin Searchable here...
  extend Searchable
end
