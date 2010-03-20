class Anotacao < CouchFoo::Base
  has_many :anexos, :class_name => 'Anexo'

  belongs_to :tarefa
  property :tarefa_id, String

  validates_presence_of :titulo, :data_criacao, :hora_criacao, :tarefa

  property :titulo, String
  property :data_criacao, DateTime
  property :hora_criacao, Time
  property :conteudo, String
  
end
