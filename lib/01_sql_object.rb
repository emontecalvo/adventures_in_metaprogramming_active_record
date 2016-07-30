require_relative 'db_connection'
require 'active_support/inflector'
# NB: the attr_accessor we wrote in phase 0 is NOT used in the rest
# of this project. It was only a warm up.

# Our job is to write a class, SQLObject, that will interact 
# with the database. By the end of this phase, we will have written 
# the following methods, just like the real ActiveRecord::Base:

# ::all: return an array of all the records in the DB
# ::find: look up a single record by primary key
# #insert: insert a new row into the table to represent the SQLObject.
# #update: update the row with the id of this SQLObject
# #save: convenience method that either calls insert/update depending
#  on whether or not the SQLObject already exists in the table.

class SQLObject
  def self.columns
    @columns_arr ||= DBConnection.execute2(<<-SQL)
      SELECT
        *
      FROM
        #{table_name}
      LIMIT
        1
    SQL
    @columns_arr.first.map { |item| item.to_sym }
  end

  def self.finalize!
    self.columns.each do |name|
      define_method(name) do
        self.attributes[name]
      end

      define_method("#{name}=") do |value|
        self.attributes[name] = value
      end
    end
  end

  def self.table_name=(table_name)
    @table_name = table_name
  end

  def self.table_name
    @table_name ||= self.to_s.tableize
  end

  def self.all
    all_things = DBConnection.execute(<<-SQL)
      SELECT
        #{table_name}.*
      FROM
        #{table_name}
    SQL
    parse_all(all_things)

  end

  def self.parse_all(results)
    all_things_arr = results.each do |x|
      all_things_arr << x.new
    end
    all_things_arr
  end

  def self.find(id)
    # ...
  end

  def initialize(params = {})
    params.each do |key, val|
      raise "unknown attribute '#{key}'" unless self.class.columns.include?(key.to_sym)
      self.send("#{key}=", val)
    end
  end

  def attributes
    @attributes ||= {}
  end

  def attribute_values
    # ...
  end

  def insert
    # ...
  end

  def update
    # ...
  end

  def save
    # ...
  end
end
