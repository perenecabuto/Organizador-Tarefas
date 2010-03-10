class Usuario < CouchFoo::Base
    has_many :quadro

    validates_uniqueness_of :email
    validates_uniqueness_of :login
    validates_presence_of :nome, :login, :email, :senha

    property :nome, String
    property :login, String
    property :email, String
    property :senha, String

    def quadro_atual
        date = Date.today

        hash_quadro = {
            :semana  => date.cweek,
            :mes     => date.month,
            :ano     => date.year
        }

        quadro_atual = self.quadro.find( :first, :conditions => hash_quadro )

        unless quadro_atual
            quadro_atual = Quadro.new(hash_quadro.merge(:usuario => self))
        end

        return quadro_atual
    end

    def self.find_by_login_and_senha(login, senha)
        return Usuario.find( :first, :conditions => {
            :login => login,
            :senha => senha
        })
    end

end
