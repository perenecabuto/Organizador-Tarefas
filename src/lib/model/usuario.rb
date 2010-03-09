class Usuario < CouchFoo::Base
    has_many :quadro

    validates_uniqueness_of :email
    validates_presence_of :nome, :email, :senha

    property :nome, String
    property :email, String
    property :senha, String

    def quadro_atual
        date = Date.today

        hash_quadro = {
            :semana  => date.cweek,
            :mes     => date.month,
            :ano     => date.year
        }

        quadro_atual = self.quadro.find( :all, :conditions => hash_quadro )[0]

        unless quadro_atual
            quadro_atual = Quadro.new(hash_quadro.merge(:usuario => self))
        end

        return quadro_atual
    end

end
