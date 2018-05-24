module ManyToMany
  def self.included(base)
    base.extend ClassMethods
  end

  module ClassMethods
    def get_related_models(database, entry, related_class)
      q = "SELECT * FROM #{related_class.table_name} related_table " \
          "INNER JOIN #{table_name} join_table " \
          "ON join_table.#{related_class.to_s.downcase}_id = related_table.id " \
          "WHERE join_table.#{entry.class.to_s.downcase}_id = #{entry.id};"

      database.execute q
    end
  end
end
