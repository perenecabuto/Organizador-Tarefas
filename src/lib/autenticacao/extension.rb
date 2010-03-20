require 'rubygems'
require 'sinatra/base'
require 'model/usuario'

module Autenticacao
  module Extension
    def self.registered(app)
      app.helpers Autenticacao::Extension::Helpers

      app.before do
        unless request.path.match %q{^/(login|cadastro|static/.*)$} or autenticado?
          redirect "/login"
        end
      end

      app.get "/login" do
        erb :login, :locals => {
          :flash => flash
        }
      end

      app.post "/login" do
        usuario = Usuario.find_by_login_and_senha(params[:login], params[:senha])
        page = "/login"

        unless usuario.nil?
          page = "/"
          self.autenticar( usuario )
        else
          flash[:error] = ["Login ou senha inválido"]
        end

        redirect page
      end

      app.get "/logout" do
        flash[:success] = "Até mais <b>#{get_usuario_autenticado.nome}</b>"
        self.logout
        redirect "/"
      end
    end

    module Helpers
      def autenticado?
        not session[:usuario].nil?
      end

      # Pega o usuario autenticado
      def get_usuario_autenticado
        return session[:usuario]
      end

      def logout
        session[:usuario] = nil
      end

      def autenticar(usuario)
        session[:usuario] = usuario
        flash[:success] = "Seja bem vindo "
      end
    end
  end
end
