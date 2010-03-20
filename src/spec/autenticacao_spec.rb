require File.dirname(__FILE__) + '/spec_helper'
require 'control/organizador_tarefas'
require 'autenticacao/extension'

module Autenticacao::Extension::Helpers
    def flash
        @flash ||= Hash.new
    end
end

describe Autenticacao::Extension, "Autenticaçao básica" do
    include Rack::Test::Methods

    def app
        unless @app
            @app = Sinatra::Application
            @app.register Autenticacao::Extension
            @app.register Autenticacao::Extension::Helpers
            @app.set(:session, Hash.new)
            @app.flash[:success] = "Seja bem vindo "
        end

        return @app
    end

    it "deve verificar se um usuario esta autenticado" do
        app.should_not be_autenticado
    end

    it "deve redirecionar para a tela de login caso nao autenticado" do
        get "/" and follow_redirect!
        last_request.url.should be_eql("http://example.org/login")
    end

    it "deve autenticar usuário e redirecionar para a primeira página" do
        post "/login" and follow_redirect!
        last_request.url.should be_eql("http://example.org/")
    end

    it "deve deslogar um usuário e sair" do
        get "/logout" and follow_redirect!
        app.should_not be_autenticado
        last_request.url.should be_eql("http://example.org/login")
    end
end
