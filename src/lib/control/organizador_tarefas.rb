require 'rubygems'
require 'sinatra/base'
require 'rack'
require 'erb'

require 'model/usuario'
require 'model/quadro'
require 'model/tarefa'

class OrganizadorDeTarefas < Sinatra::Base

    # Pega o usuario autenticado
    def get_usuario_autenticado
        return session[:usuario]
    end

    def logout
        session[:usuario] = nil
    end

    def autenticar(usuario)
        session[:usuario] = usuario
        flash[:success] = "Seja bem vindo " + usuario.nome
    end

    def get_quadro_atual
        quadro_atual = self.get_usuario_autenticado.quadro_atual
        return quadro_atual
    end

    def usuario_autenticado?
        return !session[:usuario].nil?
    end

    before do
        unless request.path.match %q{^/(login|cadastro|static/.*)$} or usuario_autenticado?
            redirect "/login"
        end
    end

    get "/login" do
        erb :login, :locals => {
            :flash => flash
        }
    end

    post "/login" do
        usuario = Usuario.find_by_login_and_senha(params[:login], params[:senha])

        unless usuario.nil?
            self.autenticar( usuario )
        else
            flash[:error] = ["Login ou senha inválido"]
        end

        redirect "/"
    end

    get "/logout" do
        self.logout
        redirect "/"
    end

    post "/cadastro" do
        unless params[:senha] == params[:repeticao_senha]
            flash[:error] = "Senhas nao conferem, digite novamente"
            redirect "/login"
            return
        end

        usuario = Usuario.new do |u|
            u.login = params[:login]
            u.nome  = params[:nome]
            u.email = params[:email]
            u.senha = params[:senha]
        end

        unless usuario.save
            flash[:error] = usuario.errors.full_messages
        else
            autenticar(usuario)
        end

        redirect "/"
    end

    get "/" do
        redirect "/quadro_tarefas"
    end

    get "/quadro_tarefas" do
        erb :quadro_tarefas, :locals => {
            :tarefas => self.get_quadro_atual.tarefas,
            :flash   => flash,
            :usuario => self.get_usuario_autenticado
        }
    end

    post "/adicionar_tarefa" do
        tarefa = Tarefa.new(params[:tarefa].merge( :quadro => self.get_quadro_atual ) )

        unless tarefa.save
            flash[:error] = tarefa.errors.full_messages
        else
            flash[:success] = 'Salvo com successo'
        end

        redirect "/quadro_tarefas"
    end

    post %r{/atualizar_tarefa/([a-z0-9\-]+)} do |id|
        tarefa = self.get_quadro_atual.tarefas.find(id)

        if params[:atualizar]
            tarefa.limpar_dias
            tarefa.update_attributes(params[:tarefa])

            if tarefa.save
                flash[:success] = "Tarefa #{tarefa.nome} atualizada com successo"
            end
        elsif params[:remover]
            if self.get_quadro_atual.tarefas.delete(tarefa)
                flash[:success] = "Tarefa #{tarefa.nome} removida com successo"
            end
        end

        flash[:error] = tarefa.errors.full_messages unless tarefa.errors.empty?

        redirect "/quadro_tarefas"
    end
end

