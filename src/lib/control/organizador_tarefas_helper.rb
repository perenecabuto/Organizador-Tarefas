require 'sinatra/base'
require 'couch_foo'
require 'erb'
require 'logger'
require 'ptbr_error_messages'

require 'model/usuario'
require 'model/quadro'
require 'model/tarefa'
require 'autenticacao/extension'

class Sinatra::Base
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

  set :environment, :development
  set :public, File.dirname(__FILE__) + '/../../public'
  set :views, File.dirname(__FILE__) + '/../../views'
end

module OrganizadorDeTarefas
  class Quadro
    register Autenticacao::Extension
  end
  
  class Cadastro
    helpers Autenticacao::Extension::Helpers
  end
end