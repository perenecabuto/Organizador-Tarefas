require 'rubygems'
require 'rack/test'
#
require 'couch_foo'
require 'model/usuario'
require 'model/quadro'
require 'model/tarefa'
require 'logger'

CouchFoo::Base.set_database(:host => "http://localhost:5984", :database => 'organizador_tarefas')
CouchFoo::Base.bulk_save_default = false
CouchFoo::Base.logger = Logger.new(STDOUT)

#include Test::Unit::Assertions

describe "Dado que estou acessando o organizador de tarefas" do

    before(:all) do
        @usuario = Usuario.new(:nome => 'TU', :email => "#{(rand * 10000).to_i}tu@odt.org", :senha => '123')
        @quadro  = @usuario.quadro_atual

        unless @usuario.save
            raise Exception.new(@usuario.errors.full_messages.join("\n") )
        end
    end

    def atualizar_quadro
        unless @quadro.save
            raise Exception.new(@quadro.errors.full_messages.join("\n") )
        end
    end

    # Quadro
    it "deve adicionar tarefas no quadro" do
        @quadro.tarefas.push(
            Tarefa.new(:nome => 'test1', :quantidade => 3),
            Tarefa.new(:nome => 'test2', :quantidade => 3)
        );

        self.atualizar_quadro
    end

    it "deve listar as tarefas de um usuario" do
        @quadro.tarefas.class.should == Array
        @quadro.tarefas.size.should == 2
    end

    it "deve atualizar tarefas no quadro" do
        @quadro.tarefas[0].nome = 'test auteracao'
        @quadro.tarefas[0].save

        tarefa = Tarefa.find(@quadro.tarefas[0].id)

        tarefa.nome.should == 'test auteracao'
    end

    it "deve remover tarefas do quadro" do
        tarefa = @quadro.tarefas[0]

        @quadro.tarefas.delete(tarefa)
        self.atualizar_quadro
        @quadro.tarefas.size == 1

        @quadro.tarefas.delete_all
        self.atualizar_quadro
        @quadro.tarefas.size == 0
    end

    # TODO Release 2
    it "deve navegar pelos quadros do usuario"

    # Usuario
    it "deve verificar se o usuario esta autenticado"
    it "deve mostrar tela de login"
    it "deve cadastra"

    # Anotacoes
    it "deve exibir as anotacoes"
    it "deve criar anotacoes"
    it "deve visualizar tarefa"
    it "deve editar as anotacoes"
    it "deve remover as anotacoes"
    # Anexos da Anotacao
    it "deve poder adicionar e remover anexos as tarefas"
    # Alerta
    it "deve receber alertas sobre data limite"


end
