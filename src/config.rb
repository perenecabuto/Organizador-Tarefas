#!/usr/bin/ruby

$LOAD_PATH.push( File.expand_path(File.dirname(__FILE__) + '/lib') );

require 'rubygems'
require 'rack'
require 'rack-flash'
require 'rack/lobster'
require 'control/organizador_tarefas/quadro'
require 'control/organizador_tarefas/cadastro'
require 'control/organizador_tarefas_helper'

puts "Iniciando ..."

App = Rack::Builder.new do
  use Rack::CommonLogger
  use Rack::ShowExceptions
  use Rack::Lint

  #use Rack::Session::Memcache
  use Rack::Session::Cookie,
      :key          => 'session',
      #:domain       => 'lukazupareli.org',
      :secret       => 'lukazuXXX',
      :path         => '/',
      :expire_after => 2592000

  use Rack::Flash

  map "/" do
    run OrganizadorDeTarefas::Quadro.new
  end
  
  map "/cadastro" do
    run OrganizadorDeTarefas::Cadastro.new
  end
end
