require_relative '../spec_helper.rb'

describe 'Dado ter uma conta cadastrada' do
  context 'Quando realizar uma requisição para o endpoint para payment' do
    it 'Então validar o status code para success', :payment_sucess do
        requet_body = {
            "endToEnd":"c74205c0-5f7b-4ee2-8fab-ef646c408fff",
            "conciliation_id":"95225008-6c6b-4310-821a-72dfe634c24e",
            "amount":10,
            "recipient":{
               "document": "70326165690",
               "name": "Builders",
               "key": "70326165690",
               "key_type":"CPF",
               "bank":{
                  "name": "Banco do Brasil",
                  "ispb":"0001"
               }
            },
            "sender":{
               "document":"41203066074",
               "name":"Candidato",
               "key":"41203066074",
               "key_type":"CPF",
               "bank":{
                  "name":"Caixa Economica Federal",
                  "ispb":"0002"
               }
            }
        }.to_json

        request = HTTParty.post('https://vagas.builders/api/builders/pix/payments', :headers => {'Aceppt' => 'application/json', 'Content-Type' => 'application/json'}, body: requet_body)
        response = request.parsed_response
        puts response

        expect(request.code).to eql(data_load(%w[status_code OK]))
        expect(response['end_to_end']).to eql(data_load(%w[pix_codes end_to_end]))
        expect(response['conciliation_id']).to eql(data_load(%w[pix_codes conciliation_id]))
        expect(response['amount']).to eql(data_load(%w[pix_codes total_value]).to_i)
        expect(response['authentication_code']).to be_a(String).and have_attributes(size: (be > 0))
        expect(response['created_at']).to be_a(String).and have_attributes(size: (be > 0))
    end
  end
end