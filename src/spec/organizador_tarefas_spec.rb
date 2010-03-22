# encoding: utf-8

require 'model/usuario'
require 'model/quadro'
require 'model/tarefa'

describe "Dado que estou acessando o organizador de tarefas" do

  before(:all) do
    @usuario = Usuario.new(
      :nome  => 'TU',
      :login => "tu_#{(rand * 10000).to_i}",
      :email => "#{(rand * 10000).to_i}tu@odt.org",
      :senha => '123'
    )

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

    @quadro.should have(2).tarefas
  end

  it "deve listar as tarefas de um usuario" do
    @quadro.tarefas.should be_a(Array)
    @quadro.should have(2).tarefas
  end

  it "deve atualizar tarefas no quadro" do
    @quadro.tarefas[0].nome = 'test alteracao'
    @quadro.tarefas[0].save

    tarefa = Tarefa.find(@quadro.tarefas[0].id)

    tarefa.nome.should be_eql('test alteracao')
  end

  it "deve remover tarefas do quadro" do
    tarefa = @quadro.tarefas[0]

    @quadro.tarefas.delete(tarefa)
    self.atualizar_quadro
    @quadro.should have(1).tarefas

    @quadro.tarefas.delete_all
    self.atualizar_quadro
    @quadro.should have(0).tarefas
  end

  # TODO Release 2
  it "deve navegar pelos quadros do usuario"

  # Alerta
  it "deve receber alertas sobre data limite"

  # Medicoes
  it "deve exibir os status da tarefa de acordo com o dia da semana"
  it "deve mostrar que esta na vespera do ultimo dia para completar uma tarefa"
  it "deve mostrar que esta no ultimo dia para completar uma tarefa"
end
