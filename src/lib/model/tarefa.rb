class Tarefa < CouchFoo::Base
    belongs_to :quadro
    property :quadro_id, String

    validates_presence_of :nome, :quantidade
    validates_uniqueness_of :nome, :scope => :quadro

    property :nome, String
    property :quantidade, Integer

    property :domingo, Boolean
    property :segunda, Boolean
    property :terca  , Boolean
    property :quarta , Boolean
    property :quinta , Boolean
    property :sexta  , Boolean
    property :sabado , Boolean
end

