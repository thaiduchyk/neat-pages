module ViewHelpers
  def request_mock(options={})
    options.reverse_merge! env: {}, host: 'test.dev', path_info: '', port: 80, protocol: 'http://'

    env = { 'action_dispatch.request.query_parameters' => {} }.merge options[:env]

    request = double()
    request.stub(:protocol).and_return options[:protocol]
    request.stub(:host).and_return options[:host]
    request.stub(:port).and_return options[:port]
    request.stub(:path_info).and_return options[:path_info]
    request.stub(:env).and_return env

    return request
  end
end
