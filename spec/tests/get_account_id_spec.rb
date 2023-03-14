require_relative '../spec_helper.rb'

describe 'Dado ter uma conta cadastrada' do
  context 'Quando realizar uma requisição para o endpoint de consulta por account_id' do
    it 'Então validar o status code para success', :get_accoud_id_success do
        request = HTTParty.get("https://vagas.builders/api/builders/accounts/#{data_load(%w[get_account_id Darth_Vader account_id])}", :headers => {"Aceppt" => "application/json"})
        response = request.parsed_response
        puts response

        expect(request.code).to eql(data_load(%w[status_code OK]))
        expect(response['account_id']).to eql(data_load(%w[get_account_id Darth_Vader account_id]))
        expect(response['document']).to eql(data_load(%w[get_account_id Darth_Vader document]))
        expect(response['name']).to eql(data_load(%w[get_account_id Darth_Vader name]))
        expect(response['amount']).to eql(data_load(%w[get_account_id Darth_Vader amount]))
        expect(response['bank']['name']).to eql(data_load(%w[get_account_id Darth_Vader bank_name]))
        expect(response['bank']['ispb']).to eql(data_load(%w[get_account_id Darth_Vader bank_ispb]))
    end

    it 'Então validar o status code para invalid_request', :get_accound_id_not_found do
      request = HTTParty.get("https://vagas.builders/api/builders/accounts/#{data_load(%w[get_account_id invalid_account_id])}", :headers => {"Aceppt" => "application/json"})
      response = request.parsed_response
      puts response

      expect(request.code).to eql(data_load(%w[status_code NOT_FOUND]))
      expect(response['timestamp'].split(/:/)[0]).to include(Time.now.to_s.split[0])
      expect(response['status']).to eql(404)
      expect(response['error']).to eql(data_load(%w[get_account_id response_error]))
      expect(response['errors']).to be_nil
    end
  end
end