require 'ostruct'

RSpec.describe F1SalesCustom::Email::Parser do

  context 'when email is from website' do

    context 'when is to SP' do
      let(:state){ 'SP' }
      let(:deparment){ 'vendas' }
      let(:email) do
        email = OpenStruct.new
        email.to = [email: 'websiteform@lojateste.f1sales.org']
        email.subject = 'Ornare "Vendas / Orçamento"'
        email.body = "De: Marcio Klepacz Email: marcioklepacz@gmail.com Assunto: Vendas / Orçamento Telefone: 11981587311 Estado: SP Endereço: Rua Bahia, 543, apt 232 Newsletter: Não Corpo da mensagem: Lead twste" 

        email
      end

      let(:parsed_email) { described_class.new(email).parse }

      it 'contains website form as source name' do
        expect(parsed_email[:source][:name]).to eq(F1SalesCustom::Email::Source.all[4][:name])
      end

      it 'contains name' do
        expect(parsed_email[:customer][:name]).to eq('Marcio Klepacz')
      end

      it 'contains email' do
        expect(parsed_email[:customer][:email]).to eq('marcioklepacz@gmail.com')
      end

      it 'contains phone' do
        expect(parsed_email[:customer][:phone]).to eq('11981587311')
      end

      it 'contains a description' do
        expect(parsed_email[:description]).to eq('Endereço cliente: Rua Bahia, 543, apt 232')
      end
    end

    context 'when is to RJ' do
      let(:state){ 'RJ' }
      let(:deparment){ 'vendas' }
      let(:email) do
        email = OpenStruct.new
        email.to = [email: 'websiteform@lojateste.f1sales.org']
        email.subject = 'Ornare "Vendas / Orçamento"'
        email.body = "De: Marcio Klepacz Email: marcioklepacz@gmail.com Assunto: Vendas / Orçamento Telefone: 11981587311 Estado: RJ Endereço: Rua Bahia, 543, apt 232 Newsletter: Não Corpo da mensagem: Lead twste" 
        email
      end

      let(:parsed_email) { described_class.new(email).parse }

      it 'contains website form as source name' do
        expect(parsed_email[:source][:name]).to eq(F1SalesCustom::Email::Source.all[1][:name])
      end
    end

    context 'when is to MT' do
      let(:state){ 'MT' }
      let(:deparment){ 'vendas' }
      let(:email) do
        email = OpenStruct.new
        email.to = [email: 'websiteform@lojateste.f1sales.org']
        email.subject = "#{deparment}: Mensagem de Carolina Martins"
        email.body = "De: Carolina Martins Email: carolmmgo@hotmail.com Telefone: 11 98376 0878 Estado: #{state} Corpo da mensagem: Olá Equipe Ornare,  Estou tentando um contato na loja mais próxima da minha casa, mas parece que os telefones abaixo não funcionam:  São Paulo – Gabriel Monteiro da Silva Al. Gabriel Monteiro da Silva, 1101 – Jd. Paulistano 2ª a 6ª das 10h às 20h e sáb. das 10h às 14h Tel.: +55 (11) 3065.6622 Assistência Técnica: +55 (11) 3090.3250  Antes de enviar o orçamento, eu gostaria de conversar com alguém da loja localizada no Jd. Paulistano.  Obrigada, Carolina Martins"

        email
      end

      let(:parsed_email) { described_class.new(email).parse }

      it 'contains website form as source name' do
        expect(parsed_email[:source][:name]).to eq(F1SalesCustom::Email::Source.all[3][:name])
      end
    end

    context 'when is to BH' do
      let(:state){ 'BH' }
      let(:deparment){ 'vendas' }
      let(:email) do
        email = OpenStruct.new
        email.to = [email: 'websiteform@lojateste.f1sales.org']
        email.subject = "#{deparment}: Mensagem de Carolina Martins"
        email.body = "De: Carolina Martins Email: carolmmgo@hotmail.com Telefone: 11 98376 0878 Estado: #{state} Corpo da mensagem: Olá Equipe Ornare,  Estou tentando um contato na loja mais próxima da minha casa, mas parece que os telefones abaixo não funcionam:  São Paulo – Gabriel Monteiro da Silva Al. Gabriel Monteiro da Silva, 1101 – Jd. Paulistano 2ª a 6ª das 10h às 20h e sáb. das 10h às 14h Tel.: +55 (11) 3065.6622 Assistência Técnica: +55 (11) 3090.3250  Antes de enviar o orçamento, eu gostaria de conversar com alguém da loja localizada no Jd. Paulistano.  Obrigada, Carolina Martins"

        email
      end

      let(:parsed_email) { described_class.new(email).parse }

      it 'contains website form as source name' do
        expect(parsed_email[:source][:name]).to eq(F1SalesCustom::Email::Source.all[2][:name])
      end
    end

    context 'when is contains "vendas" and a state' do

      let(:state){ 'AL' }
      let(:deparment){ 'vendas' }
      let(:email) do
        email = OpenStruct.new
        email.to = [email: 'websiteform@lojateste.f1sales.org']
        email.subject = "#{deparment}: Mensagem de Carolina Martins"
        email.body = "De: Carolina Martins Email: carolmmgo@hotmail.com Telefone: 11 98376 0878 Estado: #{state} Corpo da mensagem: Olá Equipe Ornare,  Estou tentando um contato na loja mais próxima da minha casa, mas parece que os telefones abaixo não funcionam:  São Paulo – Gabriel Monteiro da Silva Al. Gabriel Monteiro da Silva, 1101 – Jd. Paulistano 2ª a 6ª das 10h às 20h e sáb. das 10h às 14h Tel.: +55 (11) 3065.6622 Assistência Técnica: +55 (11) 3090.3250  Antes de enviar o orçamento, eu gostaria de conversar com alguém da loja localizada no Jd. Paulistano.  Obrigada, Carolina Martins"

        email
      end

      let(:parsed_email) { described_class.new(email).parse }

      it 'contains website form as source name' do
        expect(parsed_email[:source][:name]).to eq(F1SalesCustom::Email::Source.all.first[:name])
      end

      it 'contains name' do
        expect(parsed_email[:customer][:name]).to eq('Carolina Martins')
      end

      it 'contains email' do
        expect(parsed_email[:customer][:email]).to eq('carolmmgo@hotmail.com')
      end

      it 'contains phone' do
        expect(parsed_email[:customer][:phone]).to eq('11983760878')
      end

      it 'contains product' do
        expect(parsed_email[:product]).to eq(deparment.capitalize + ' - ' + state)
      end

      it 'contains a message' do
        expect(parsed_email[:message]).to eq("Olá Equipe Ornare,  Estou tentando um contato na loja mais próxima da minha casa, mas parece que os telefones abaixo não funcionam:  São Paulo – Gabriel Monteiro da Silva Al. Gabriel Monteiro da Silva, 1101 – Jd. Paulistano 2ª a 6ª das 10h às 20h e sáb. das 10h às 14h Tel.: +55 (11) 3065.6622 Assistência Técnica: +55 (11) 3090.3250  Antes de enviar o orçamento, eu gostaria de conversar com alguém da loja localizada no Jd. Paulistano.  Obrigada, Carolina Martins")
      end
    end

  end
end


