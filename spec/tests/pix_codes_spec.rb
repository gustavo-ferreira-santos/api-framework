require_relative '../spec_helper.rb'

describe 'Dado ter uma conta cadastrada' do
  context 'Quando realizar uma requisição para o endpoint para envio de pix' do
    it 'Então validar o status code para success', :pix_codes_sucess do
        request = HTTParty.post('https://vagas.builders/api/builders/pix/codes', :headers => {'Aceppt' => 'application/json', 'Content-Type' => 'application/json'}, body: {'encoded_value' => data_load(%w[pix_codes encoded_qr_code])}.to_json)
        response = request.parsed_response
        puts response

        expect(request.code).to eql(data_load(%w[status_code OK]))
        expect(response['end_to_end']).to eql(data_load(%w[pix_codes end_to_end]))
        expect(response['conciliation_id']).to eql(data_load(%w[pix_codes conciliation_id]))
        expect(response['total_value']).to eql(data_load(%w[pix_codes total_value]))
        expect(response['holder']['document']).to eql(data_load(%w[pix_codes holder_document]))
        expect(response['holder']['name']).to eql(data_load(%w[pix_codes holder_name]))
        expect(response['holder']['key']).to eql(data_load(%w[pix_codes holder_key]))
        expect(response['holder']['key_type']).to eql(data_load(%w[pix_codes holder_key_type]))
        expect(response['holder']['bank']['name']).to eql(data_load(%w[pix_codes bank_name]))
        expect(response['holder']['bank']['ispb']).to eql(data_load(%w[pix_codes bank_ispb]))
    end

    it 'Então validar o status code para not_found', :pix_codes_not_found do
        request = HTTParty.post('https://vagas.builders/api/builders/pix/codes', :headers => {'Aceppt' => 'application/json', 'Content-Type' => 'application/json'}, body: {'encoded_value' => data_load(%w[pix_codes invalid_qr_code])}.to_json)
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