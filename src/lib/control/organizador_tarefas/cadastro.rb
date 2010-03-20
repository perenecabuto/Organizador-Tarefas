require 'sinatra/base'

module OrganizadorDeTarefas
  class Cadastro < Sinatra::Base

    post "/?" do
      unless params[:senha] == params[:repeticao_senha]
        flash[:error] = "Senhas nao conferem, digite novamente"
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

  end
end 