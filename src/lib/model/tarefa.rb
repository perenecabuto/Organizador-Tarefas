class Tarefa < CouchFoo::Base
    belongs_to :quadro
    property :quadro_id, String

    property :nome, String
    property :quantidade, Integer

    property :domingo, Boolean
    property :segunda, Boolean
    property :terca  , Boolean
    property :quarta , Boolean
    property :quinta , Boolean
    property :sexta  , Boolean
    property :sabado , Boolean

    validates_presence_of   :nome, :quantidade
    validates_uniqueness_of :nome, :scope => :quadro
    validates_numericality_of :quantidade, :less_than_or_equal_to => 7

    def limpar_dias
        dias = {}

        [:segunda,:terca,:quarta,:quinta,:sexta,:sabado,:domingo].each do |d|
            dias[d] = false
        end

        self.update_attributes( dias )

        return
    end
end

