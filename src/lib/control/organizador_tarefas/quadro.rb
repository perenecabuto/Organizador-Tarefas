require 'sinatra/base'

module OrganizadorDeTarefas
  class Quadro < Sinatra::Base

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
  
    def get_quadro_atual
      quadro_atual = self.get_usuario_autenticado.quadro_atual
      return quadro_atual
    end
  end
end
