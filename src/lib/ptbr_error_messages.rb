class CouchFoo::Errors
  @@default_error_messages = {
    :inclusion => "não está presente na lista %d",
    :exclusion => "está reservado",
    :invalid => "não é válido",
    :confirmation => "não foi confirmado",
    :accepted  => "precisa ser aceito",
    :empty => "não pode ser vazio",
    :blank => "não pode estar em branco",
    :too_long => "é muito grande (máximo de %d caracteres)",
    :too_short => "é muito curto (mínimo de %d caracteres)",
    :wrong_length => "o tamanho está incorreto (deveria ser %d caracteres)",
    :taken => "já foi encontrado",
    :not_a_number => "não é um número",
    :greater_than => "precisa ser maior que %d",
    :greater_than_or_equal_to => "precisa ser maior ou igual a %d",
    :equal_to => "precisa ser igual a %d",
    :less_than => "precisa ser menor que %d",
    :less_than_or_equal_to => "precisa ser menor ou igual a %d",
    :odd => "precisa ser impar",
    :even => "precisa ser par"
  }
end
