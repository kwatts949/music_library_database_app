# file: lib/database_connection.rb

require 'pg'

# This class is a thin "wrapper" around the
# PG library. We'll use it in our project to interact
# with the database using SQL.

def self.connect
  # If the environment variable (set by Render)
  # is present, use this to open the connection.
  if ENV['postgres://music_library_database_cyef_user:uY1eMRJxdznGg07ZozbzxK3n0S3Y1gWx@dpg-cdh5qm2en0hl21l18spg-a/music_library_database_cyef'] != nil
    @connection = PG.connect(ENV['postgres://music_library_database_cyef_user:uY1eMRJxdznGg07ZozbzxK3n0S3Y1gWx@dpg-cdh5qm2en0hl21l18spg-a/music_library_database_cyef'])
    return
  end

  if ENV['ENV'] == 'test'
    database_name = 'music_library__new_test'
  else
    database_name = 'music_library_new'
  end
  @connection = PG.connect({ host: '127.0.0.1', dbname: database_name })
end


  # This method executes an SQL query 
  # on the database, providing some optional parameters
  # (you will learn a bit later about when to provide these parameters).
  def self.exec_params(query, params)
    if @connection.nil?
      raise 'DatabaseConnection.exec_params: Cannot run a SQL query as the connection to'\
      'the database was never opened. Did you make sure to call first the method '\
      '`DatabaseConnection.connect` in your app.rb file (or in your tests spec_helper.rb)?'
    end
    @connection.exec_params(query, params)
  end