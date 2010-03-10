require 'rubygems'
require 'rack/test'
require 'model/usuario'
require 'model/quadro'
require 'model/tarefa'
require 'logger'

CouchFoo::Base.set_database(:host => "http://localhost:5984", :database => 'organizador_tarefas')
CouchFoo::Base.bulk_save_default = false
CouchFoo::Base.logger = Logger.new(STDOUT)

describe Usuario do
    it "deve possuir nome, email, login, senha" do
        propriedades = Usuario.properties.collect {|i| i.name}
        propriedades.should include(:nome, :email, :login, :senha)
    end
end
