require "ornare/version"

require "f1sales_custom/parser"
require "f1sales_custom/source"
require "f1sales_helpers"

module Ornare
  
  class F1SalesCustom::Email::Source
    def self.all
      [
        {
          email_id: 'websiteform',
          name: 'Site - Vendas - Outros Estados'
        },
        {
          email_id: 'websiteform',
          name: 'Site - Vendas - RJ'
        },
        {
          email_id: 'websiteform',
          name: 'Site - Vendas - BH'
        },
        {
          email_id: 'websiteform',
          name: 'Site - Vendas - MT'
        },
        {
          email_id: 'websiteform',
          name: 'Site - Vendas - SP - GMS'
        },
        {
          email_id: 'websiteform',
          name: 'Site - Vendas - SP - D&D'
        },
      ]
    end 
  end

  class F1SalesCustom::Email::Parser
    def parse
      parsed_email = @email.body.colons_to_hash
      state = parsed_email['estado'].split("\n").first
      message = @email.body.split('Estado').last.split("\n").drop(1).join("\n")
      department = @email.subject.split(':').first

      source = case state.strip
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
          name: parsed_email['de'],
          phone: parsed_email['telefone'].tr('^0-9', ''),
          email: parsed_email['email']
        },
        product: department.capitalize + ' - ' + state,
        message: message,
      }
    end

  end
end
