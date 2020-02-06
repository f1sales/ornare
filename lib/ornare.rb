require "ornare/version"

require "f1sales_custom/parser"
require "f1sales_custom/source"
require "f1sales_helpers"

module Ornare
  
  class F1SalesCustom::Email::Source
    def self.all
      [
        {
          email_id: 'website_form_sender',
          name: 'Site - Vendas - Outros Estados'
        },
        {
          email_id: 'website_form_sender',
          name: 'Site - Vendas - RJ'
        },
        {
          email_id: 'website_form_sender',
          name: 'Site - Vendas - BH'
        },
        {
          email_id: 'website_form_sender',
          name: 'Site - Vendas - MT'
        },
        {
          email_id: 'website_form_sender',
          name: 'Site - Vendas - SP - GMS'
        },
        {
          email_id: 'website_form_sender',
          name: 'Site - Vendas - SP - D&D'
        },
      ]
    end 
  end

  class F1SalesCustom::Email::Parser
    def parse
      parsed_email = @email.body.colons_to_hash(/(Telefone|Assunto|Estado|Endereço|Newsletter|De|Email|Corpo da mensagem).*?:/, false)
      state = parsed_email['estado']
      message = parsed_email['corpo_da_mensagem']
      department = @email.subject.split(':').first
      name, email = parsed_email['de'].split(/</)

      source = case state
      when 'RJ'
       F1SalesCustom::Email::Source.all[1]
      when 'BH'
       F1SalesCustom::Email::Source.all[2]
      when 'MT'
       F1SalesCustom::Email::Source.all[3]
      when 'SP'
       F1SalesCustom::Email::Source.all[4]
      else
       F1SalesCustom::Email::Source.all[0]
      end

      source_name = source[:name]

      {
        source: {
          name: source_name, 
        },
        customer: {
          name: name.strip,
          phone: parsed_email['telefone'].tr('^0-9', ''),
          email: (email || "").gsub('>', '')
        },
        product: department.capitalize + ' - ' + state,
        message: message,
        description: "Endereço cliente: #{parsed_email['endereo']}"
      }
    end

  end
end
