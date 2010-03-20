require File.dirname(__FILE__) + '/spec_helper'
require 'model/anotacao'
require 'model/tarefa'
require 'model/quadro'

describe Anotacao do
  
  before(:all) do
    @anotacoes = Array.new
    @random_number = ( rand * 10000 ).to_i
    @tarefa ||= Tarefa.new do |t|
        t.quadro     = Quadro.new
        t.nome       = "T #{@random_number}"
        t.quantidade = 1
        t.save
    end
  end
  
  it "deve ter titulo, data_criacao, conteudo, anexos e tarefa" do
    Anotacao.property_names.should include(
      :titulo, :data_criacao, :hora_criacao, :conteudo
   )

    Anotacao.new.respond_to?(:tarefa).should be_true
    Anotacao.new.respond_to?(:anexos).should be_true
  end

  it "deve criar anotacoes" do
    2.times do
        anotacao = Anotacao.new do |a|
            a.tarefa       = @tarefa
            a.titulo       = "A #{@random_number}"
            a.data_criacao = Date.today
            a.hora_criacao = Time.now
        end

        anotacao.save

        anotacao.errors.full_messages.should be_empty
        @anotacoes.push( anotacao )
    end
  end

  it "deve listar anotacoes" do
    # Atualiza para garantir que foi salvo
    @tarefa.reload

    @tarefa.should have_at_least(2).anotacoes
  end

  it "deve atualizar uma anotação" do
    @anotacoes.each do |a|
      a.titulo = "Alterado"
      a.save
    end

    @tarefa.reload
    @tarefa.anotacoes.each do |t|
        t.titulo.should be_eql("Alterado")
    end
  end

  it "deve ser possível adicionar anexos a uma anotação"
  it "poder remover anexos das anotações"
  it "deve ter uma arquivo associado ao ID da anotação"

  it "deve deletar uma anotação" do
    @tarefa.anotacoes.delete(@anotacoes.shift)
    @tarefa.save

    @tarefa.errors.full_messages.should be_empty
    @tarefa.should have(1).anotacoes
  end
end
