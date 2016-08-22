require_relative 'db_connection'
require_relative 'sql_object'

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

    parse_all(results)
  end
end

class SQLObject
  extend Searchable
end
