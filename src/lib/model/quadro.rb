class Quadro < CouchFoo::Base
    has_many :tarefas, :class_name => 'Tarefa'

    belongs_to :usuario
    property :usuario_id, String

    validates_presence_of :usuario, :semana, :mes, :ano

    property :semana, Integer
    property :mes, Integer
    property :ano, Integer
end

