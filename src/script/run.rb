#!/usr/bin/ruby

$LOAD_PATH.push( File.expand_path(File.dirname(__FILE__) + '/../lib') );

require 'rubygems'
require 'control/organizador_tarefas'
require 'control/organizador_tarefas_helper'

puts "Iniciando ..."
OrganizadorDeTarefas.run!

