#!/usr/bin/ruby

$LOAD_PATH.push( File.expand_path(File.dirname(__FILE__) + '/../lib') );

require 'rubygems'
require 'sinatra'
require 'logger'
require 'couch_foo'
require 'rack-flash'
require 'ptbr_error_messages'

require 'control/organizador_tarefas'

CouchFoo::Base.set_database(:host => "http://localhost:5984", :database => 'organizador_tarefas')
CouchFoo::Base.bulk_save_default = false
CouchFoo::Base.logger = Logger.new(STDOUT)

class OrganizadorDeTarefas
    set :server, %w[thin webrick mongrel]

    use Rack::Session::Cookie,
        :key          => 'rack.session',
        #:domain       => 'foo.com',
        #:secret       => 'secret'
        :path         => '/',
        :expire_after => 2592000

    use Rack::Flash

    set :public, File.dirname(__FILE__) + '/../static'
    set :views, File.dirname(__FILE__) + '/../views'

    #disable :logging, :dump_errors
    enable :clean_trace, :sessions

    set :environment, :development
end

puts "Iniciando ..."
OrganizadorDeTarefas.run!

