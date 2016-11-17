describe Zhima::Ivs do
  before(:all) do
    params = {
      product_code: 'w1010100000000000103',
      transaction_id: 'transaction_id',
      cert_no: 'xxxxxxxxxxxxxxxxxxxxxx',
      cert_type: '100',
      name: 'name',
      mobile: '18888888888'
    }
    biz_response = {
      success: true, biz_no: 'ZM201611173000000434300378670913',
      ivs_detail: [
        {code: 'CERTNO_Match_Trust_Self_Sharing_Good', description: URI.encode_www_form_component('身份证号与其他信息匹配，匹配后的信息被一个用户使用')},
        {code: 'PHONE_Match_Trust_Self_Recency_Good', description: URI.encode_www_form_component('电话号码与其他信息匹配，匹配后的信息近期较活跃')},
        {code: 'NAME_Match_Sharing_Good', description: URI.encode_www_form_component('姓名与其他信息匹配，匹配后的信息被一个用户使用')}
      ],
      ivs_score: 99
    }
    stub_zhima_request(biz_response)
    @result = Zhima::Score.get(params)
  end

  it "success" do
    expect(@result['success']).to eq true
  end

  it "get ivs_detail" do
    expect(@result['ivs_detail'].count).to eq 3
  end

  it "get ivs_score" do
    expect(@result['ivs_score']).to eq 99
  end
end
