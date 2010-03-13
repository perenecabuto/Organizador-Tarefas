$LOAD_PATH.unshift File.join(File.dirname(__FILE__), '../lib/')

require 'rubygems'
require 'rack/test'
require 'couch_foo'
require 'logger'

CouchFoo::Base.set_database(:host => "http://localhost:5984", :database => 'organizador_tarefas')
CouchFoo::Base.bulk_save_default = false
CouchFoo::Base.logger = Logger.new(STDOUT)

