require File.dirname(__FILE__) + '/spec_helper'
require 'model/usuario'

describe Usuario do
    it "deve possuir nome, email, login, senha" do
        Usuario.property_names.should include(:nome, :email, :login, :senha)
    end
end
