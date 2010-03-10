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
    validates_numericality_of :quantidade, :less_than_or_equal_to => 7, :greater_than => 0

    def quantidade_dias_executados
        total = 0

        total =+ 1 if self.domingo
        total =+ 1 if self.segunda
        total =+ 1 if self.terca
        total =+ 1 if self.quarta
        total =+ 1 if self.quinta
        total =+ 1 if self.sexta
        total =+ 1 if self.sabado

        return total
    end

    def limpar_dias
        dias = {}

        [:segunda,:terca,:quarta,:quinta,:sexta,:sabado,:domingo].each do |d|
            dias[d] = false
        end

        self.update_attributes( dias )

        return
    end
end

