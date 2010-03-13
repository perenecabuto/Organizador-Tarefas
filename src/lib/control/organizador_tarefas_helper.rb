require 'sinatra/base'
require 'couch_foo'
require 'rack'
require 'rack-flash'
require 'erb'
require 'logger'

require 'ptbr_error_messages'
require 'model/usuario'
require 'model/quadro'
require 'model/tarefa'
require 'autenticacao/extension'

class OrganizadorDeTarefas
    set :server, %w[webrick thin mongrel]

    configure :development do
        CouchFoo::Base.set_database(:host => "http://localhost:5984", :database => 'organizador_tarefas')
        CouchFoo::Base.bulk_save_default = false
        CouchFoo::Base.logger = Logger.new(STDOUT)
    end

    configure :test do
        CouchFoo::Base.set_database(:host => "http://localhost:5984", :database => 'organizador_tarefas')
        CouchFoo::Base.bulk_save_default = false
        CouchFoo::Base.logger = Logger.new(STDOUT)
    end


    use Rack::Session::Cookie,
        :key          => 'rack.session',
        #:domain       => 'foo.com',
        #:secret       => 'secret'
        :path         => '/',
        :expire_after => 2592000

    use Rack::Flash

    #disable :logging, :dump_errors
    enable :clean_trace, :sessions

    set :environment, :development
    set :public, File.dirname(__FILE__) + '/../../public'
    set :views, File.dirname(__FILE__) + '/../../views'

    register Autenticacao::Extension
end

