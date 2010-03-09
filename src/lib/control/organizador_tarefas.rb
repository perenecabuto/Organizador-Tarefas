require 'rubygems'
require 'sinatra/base'
require 'rack'
require 'erb'

require 'model/usuario'
require 'model/quadro'
require 'model/tarefa'

class OrganizadorDeTarefas < Sinatra::Base

    def get_usuario_autenticado
        session[:usuario] ||= Usuario.new do |u|
            u.nome  = "Test"
            u.email = "Test" + ( rand * 10000 ).to_i.to_s
            u.senha = "Test"
        end

        session[:usuario].save if session[:usuario].new_record?

        return session[:usuario]
    end

    def get_quadro_atual
        quadro_atual = self.get_usuario_autenticado.quadro_atual
        return quadro_atual
    end

    get "/" do
        redirect "/quadro_tarefas"
    end

    get "/quadro_tarefas" do
        erb :quadro_tarefas, :locals => {
            :tarefas => self.get_quadro_atual.tarefas,
            :flash   => flash
        }
    end

    post "/adicionar_tarefa" do
        tarefa = Tarefa.new(params[:tarefa].merge( :quadro => self.get_quadro_atual ) )

        unless tarefa.save
            flash[:error] = tarefa.errors.full_messages
        else
            flash[:sucess] = 'Salvo com sucesso'
        end

        redirect "/quadro_tarefas"
    end

    post %r{/atualizar_tarefa/([a-z0-9\-]+)} do |id|
        tarefa = self.get_quadro_atual.tarefas.find(id)

        if params[:atualizar]
            tarefa.update_attributes(params[:tarefa])
            if tarefa.save
                flash[:sucess] = "Tarefa #{tarefa.nome} atualizada com sucesso"
            end
        elsif params[:remover]
            if self.get_quadro_atual.tarefas.delete(tarefa)
                flash[:sucess] = "Tarefa #{tarefa.nome} removida com sucesso"
            end
        end

        flash[:error] = tarefa.errors.full_messages unless tarefa.errors.empty?

        redirect "/quadro_tarefas"
    end
end

